/// <reference types="vitest" />
import {defineConfig} from "vite";
import react from "@vitejs/plugin-react";
import path from "node:path";

export default defineConfig({
    build: {
        chunkSizeWarningLimit: 2048,
        rollupOptions: {
            output: {
                manualChunks(id) {
                    if (id.includes("@formio")) return "formio";
                    if (id.includes("@gemeente-denhaag")) return "gemeente-denhaag"
                    if (id.includes("@nl-portal")) return "nl-portal"
                },
            },
        },
        outDir: "build",
        commonjsOptions: {transformMixedEsModules: true}
    },
    html: {
        cspNonce: "##NL_PORTAL_NONCE##"
    },
    plugins: [
        react(),
    ],
    test: {
        css: true,
        environment: "jsdom",
        globals: true,
    },
    resolve: {
        alias: {
            '@apollo/client': path.resolve('node_modules/@apollo/client/index.js'),
        },
    },
    ssr: {noExternal: true},
});
