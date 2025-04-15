import {defineConfig} from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
    build: {
        outDir: "build",
        commonjsOptions: {transformMixedEsModules: true}
    },
    html: {
        cspNonce: "##NL_PORTAL_NONCE##"
    },
    plugins: [
        react(),
    ],
});
