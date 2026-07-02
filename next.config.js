import os from 'node:os';

const cpuCount =
  typeof os.availableParallelism === 'function' ? os.availableParallelism() : os.cpus().length;
const defaultWorkerCount = Math.max(1, Math.floor(cpuCount / 2));
const configuredWorkerCount = Number(process.env.NEXT_CPU_WORKERS);
const workerCount =
  Number.isFinite(configuredWorkerCount) && configuredWorkerCount > 0
    ? Math.floor(configuredWorkerCount)
    : defaultWorkerCount;

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: false,
  poweredByHeader: false,
  agentRules: false,
  output: 'standalone',
  experimental: {
    cpus: workerCount,
    memoryBasedWorkersCount: false,
    workerThreads: true,
    turbopackPluginRuntimeStrategy: 'workerThreads',
  },
  async rewrites() {
    return [
      {
        source: '/assets/:path*',
        destination: '/api/assets/:path*',
      },
    ];
  },
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin',
          },
        ],
      },
      {
        source: '/assets/:path*',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=31536000, immutable',
          },
        ],
      },
    ];
  },
};

export default nextConfig;
