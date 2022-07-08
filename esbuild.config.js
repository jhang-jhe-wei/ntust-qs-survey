const esbuild = require('esbuild');
const { stimulusPlugin } = require('esbuild-plugin-stimulus');
const path = require('path');

esbuild.build({
  entryPoints: ["application.js"],
  bundle: true,
  minify: true,
  outdir: path.join(process.cwd(), "app/assets/builds"),
  watch: !!process.env.DEV_WATCH,
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  plugins: [stimulusPlugin()],
}).catch(() => process.exit(1));
