import {
    AccountPage,
    CaseDetailsPage,
    CasesPage,
    EditContactInfoPage,
    MessageDetailsPage,
    MessagesPage,
    NoMatchPage,
    OverviewPage,
    TaskDetailsPage,
    TasksPage,
} from "@nl-portal/nl-portal-user-interface";
import {OidcCallbackPage} from "@nl-portal/nl-portal-authentication";
import {paths} from "./paths";
import {config} from "./config";
import {Navigate} from "react-router";

export const routes = [
    {
        path: paths.overview,
        handle: {label: "breadcrumb.overview"},
        element: <OverviewPage showIntro/>,
    },
    {
        path: paths.cases,
        handle: {label: "breadcrumb.cases"},
        children: [
            {
                index: true,
                handle: {label: "breadcrumb.cases"},
                element: <CasesPage/>,
            },
            {
                path: paths.case(),
                handle: {label: "breadcrumb.cases.details"},
                element: <CaseDetailsPage showContactTimeline/>,
            },
        ],
    },
    {
        path: paths.tasks,
        handle: {label: "breadcrumb.tasks"},
        children: [
            {
                index: true,
                handle: {label: "breadcrumb.tasks"},
                element: <TasksPage/>,
            },
            {
                path: paths.task(),
                handle: {label: "breadcrumb.tasks.details"},
                element: <TaskDetailsPage/>,
            },
        ],
    },
    {
        path: paths.messages,
        handle: {label: "breadcrumb.messages"},
        children: [
            {
                index: true,
                handle: {label: "breadcrumb.messages"},
                element: <MessagesPage/>,
            },
            {
                path: paths.message(),
                handle: {label: "breadcrumb.messages.details"},
                element: <MessageDetailsPage/>,
            },
        ],
    },
    {
        path: paths.account,
        handle: {label: "breadcrumb.account"},
        children: [
            {
                index: true,
                handle: {label: "breadcrumb.account"},
                element: (
                    <AccountPage
                        showInhabitantAmount={config.SHOW_INHABITANT_AMOUNT}
                        addressResearchUrl={config.ADDRESS_RESEARCH_URL}
                    />
                ),
            },
            {
                path: paths.changeContactInfo,
                handle: {label: "breadcrumb.account.editContactInfo"},
                element: <EditContactInfoPage/>,
            },
        ],
    },
    {
        path: new URL(window.OIDC_REDIRECT_URI).pathname,
        handle: {label: "breadcrumb.oidc"},
        element: <OidcCallbackPage/>,
    },
    {
        path: paths.noMatch,
        handle: {label: "breadcrumb.noMatch"},
        element: <NoMatchPage contactLink={{target: "_blank"}}/>,
    },
    {
        path: "*",
        handle: {label: "breadcrumb.noMatch"},
        element: <Navigate to={paths.noMatch}/>,
    },
];
