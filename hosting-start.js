import cluster from 'node:cluster';
import { cpus } from 'node:os';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const __dirname = dirname(fileURLToPath(import.meta.url));
const cpuCount = Math.max(1, cpus().length || 1);

if (cluster.isPrimary) {
  console.log(`Primary process ${process.pid} is running`);
  console.log(`Starting ${cpuCount} worker(s)...`);

  for (let i = 0; i < cpuCount; i++) {
    cluster.fork();
  }

  cluster.on('exit', (worker, code, signal) => {
    console.log(
      `Worker ${worker.process.pid} died (code: ${code}, signal: ${signal}). Restarting...`
    );
    cluster.fork();
  });
} else {
  await import(join(__dirname, 'server.js'));
}
