import ReactDOM from "react-dom/client";
import App from "./App";
import "./index.css";
import {RouterProvider} from "@nl-portal/nl-portal-user-interface";
import {routes} from "./constants/routes";
import verifyConfig from "./util/verify-config";
import {menuItems} from "./constants/menu-items.tsx";

ReactDOM.createRoot(document.getElementById("root")!).render(
    verifyConfig() ?
        <RouterProvider
            element={<App/>}
            routes={routes}
            navigationItems={menuItems}
        />
        : null,
);
