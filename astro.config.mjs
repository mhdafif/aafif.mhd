// @ts-check
import { defineConfig } from "astro/config";
import devtoolsJson from 'vite-plugin-devtools-json';
import tailwindcss from "@tailwindcss/vite";

import icon from "astro-icon";

// https://astro.build/config
export default defineConfig({
  vite: {
    plugins: [tailwindcss(), devtoolsJson(),],
    resolve: {
      alias: {
        "@": "/src",
      },
    },
    build: {
      sourcemap: false
    }
  },
  output: "static",
  integrations: [icon()],
});