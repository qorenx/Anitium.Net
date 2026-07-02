const CACHE_VERSION = 'v1.2.0';
const STATIC_CACHE = `anitium-static-${CACHE_VERSION}`;
const IMAGE_CACHE = `anitium-images-${CACHE_VERSION}`;
const OFFLINE_URL = '/offline.html';

const PRECACHE_ASSETS = [
  OFFLINE_URL,
  '/manifest.json',
  '/favicon-16x16.png',
  '/favicon-32x32.png',
  '/icon-192.png',
  '/icon-512.png',
];

const STATIC_ASSET_PATTERN = /\.(?:js|css|woff2?|ttf|eot|svg|ico)$/i;
const IMAGE_PATTERN = /\.(?:png|jpe?g|webp|gif|avif)$/i;
const MAX_IMAGE_ENTRIES = 120;

self.addEventListener('install', event => {
  event.waitUntil(
    caches
      .open(STATIC_CACHE)
      .then(cache => cache.addAll(PRECACHE_ASSETS))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches
      .keys()
      .then(cacheNames =>
        Promise.all(
          cacheNames
            .filter(
              cacheName =>
                cacheName.startsWith('anitium-') &&
                ![STATIC_CACHE, IMAGE_CACHE].includes(cacheName)
            )
            .map(cacheName => caches.delete(cacheName))
        )
      )
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', event => {
  const { request } = event;

  if (request.method !== 'GET') return;

  const url = new URL(request.url);
  if (!['http:', 'https:'].includes(url.protocol)) return;

  if (isApiRequest(url)) return;

  if (request.mode === 'navigate') {
    event.respondWith(networkFirstNavigation(request));
    return;
  }

  if (url.origin === self.location.origin && isStaticAsset(url.pathname)) {
    event.respondWith(cacheFirst(request, STATIC_CACHE));
    return;
  }

  if (isImage(url.pathname)) {
    event.respondWith(staleWhileRevalidateImage(request));
  }
});

self.addEventListener('message', event => {
  if (event.data?.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }

  if (event.data?.type === 'CLEAR_CACHE') {
    event.waitUntil(
      caches
        .keys()
        .then(cacheNames => Promise.all(cacheNames.map(cacheName => caches.delete(cacheName))))
    );
  }
});

self.addEventListener('push', event => {
  let data = {};

  try {
    data = event.data ? event.data.json() : {};
  } catch {
    data = {};
  }

  const options = {
    body: data.body || 'New notification',
    icon: '/icon-192.png',
    badge: '/icon-192.png',
    data: {
      url: data.url || '/',
    },
  };

  event.waitUntil(self.registration.showNotification(data.title || 'Anitium', options));
});

self.addEventListener('notificationclick', event => {
  event.notification.close();

  const targetUrl = event.notification.data?.url || '/';
  event.waitUntil(
    self.clients.matchAll({ type: 'window', includeUncontrolled: true }).then(clients => {
      const existingClient = clients.find(client => client.url === targetUrl);
      if (existingClient) {
        existingClient.focus();
        return;
      }

      return self.clients.openWindow(targetUrl);
    })
  );
});

async function networkFirstNavigation(request) {
  try {
    return await fetch(request);
  } catch {
    return (await caches.match(OFFLINE_URL)) || offlineTextResponse();
  }
}

async function cacheFirst(request, cacheName) {
  const cached = await caches.match(request);
  if (cached) return cached;

  const response = await fetch(request);
  if (response.ok) {
    const cache = await caches.open(cacheName);
    await cache.put(request, response.clone());
  }

  return response;
}

async function staleWhileRevalidateImage(request) {
  const cached = await caches.match(request);
  const refresh = fetch(request)
    .then(async response => {
      if (response.ok || response.type === 'opaque') {
        const cache = await caches.open(IMAGE_CACHE);
        await cache.put(request, response.clone());
        await trimCache(IMAGE_CACHE, MAX_IMAGE_ENTRIES);
      }

      return response;
    })
    .catch(() => null);

  return cached || refresh || offlineTextResponse();
}

async function trimCache(cacheName, maxEntries) {
  const cache = await caches.open(cacheName);
  const keys = await cache.keys();
  const overflow = keys.length - maxEntries;

  if (overflow <= 0) return;

  await Promise.all(keys.slice(0, overflow).map(key => cache.delete(key)));
}

function isApiRequest(url) {
  return url.pathname.startsWith('/api/') || url.pathname.startsWith('/v1/');
}

function isStaticAsset(pathname) {
  return pathname.startsWith('/assets/') || STATIC_ASSET_PATTERN.test(pathname);
}

function isImage(pathname) {
  return IMAGE_PATTERN.test(pathname);
}

function offlineTextResponse() {
  return new Response('Offline', {
    status: 503,
    headers: {
      'Content-Type': 'text/plain; charset=utf-8',
    },
  });
}
