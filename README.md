<img alt="NL Portal Logo" src=".github/readme/images/nl-portal-logo.svg">

![NL Portal BE 3.0.3](https://img.shields.io/badge/NL_Portal_BE-3.0.3-blue)
![NL Portal FE 3.0.2](https://img.shields.io/badge/NL_Portal_FE-3.0.2-blue)

This repository contains reference implementations for the NL Portal Backend and Frontend Apps.
It also contains a Docker Compose file for starting up a pre-configured NL Portal Demo without having to write any code.

#### Compose file structure

The compose file is build up out of multiple sets of containers (profiles) that together enable certain functionality
e.g. the `haalcentraal` profile contains services for haalcentraal-brp and haalcentraal-bewoning so you can choose to
not compose those if you don't require them. If a service is missing a profile, that means it's a core requirement
for the app and will be composed by default.

| Service                                | Port  | Profile          |
|----------------------------------------|-------|------------------|
| Pre-built NL Portal App Backend        | 8080  | remote           |
| Pre-built NL Portal App Frontend       | 3000  | remote           |
| DIY NL Portal App Backend              | 8080  | local            |
| DIY NL Portal App Frontend             | 3000  | local            |
| NL Portal Database                     | 54321 | -                |
| NL Portal Configuration Panel Router   | 3001  | config           |
| NL Portal Configuration Panel Backend  | 8090  | config           |
| NL Portal Configuration Panel Frontend | 8091  | config           |
| NL Portal Configuration Panel Database | 54322 | config           |
| Keycloak                               | 8082  | -                |
| Open Zaak                              | 8001  | zgw, openzaak    |
| Objecten API                           | 8010  | zgw, objecten    |
| Objecttypen API                        | 8011  | zgw, objecten    |
| Open Notificaties                      | 8012  | zgw, objecten    |
| OpenKlant 2                            | 8014  | zgw, openklant   |
| OpenProduct                            | 8015  | zgw, openproduct |
| Haalcentraal BRP                       | 5010  | haalcentraal     |
| Haalcentraal Bewoning                  | 5011  | haalcentraal     |

All of the above services are set up to expose their ports via the helper server `localhost`. This service defines the
external port mapping.

**NB! The profiles `remote` and `local` can not be run at the same time due to conflicting port mapping.**

## Running the application

Follow one of the following guides to start up the application:

* [Run the prebuilt app](#pulling-and-running-the-prebuilt-apps)
* [Build and run your own app](#building-and-running-your-own-apps)
* [Running from source](#running-from-source)

### Pulling and running the prebuilt apps

#### Requirements

The following software has to be installed to be able to use this application:

* Docker Desktop

#### Steps

Running the prebuilt docker images can be done via your favourite IDE by running the `docker-compose` file with
the `remote` and `zgw` profiles or by running the following command in your terminal:

```shell
docker compose --profile remote --profile zgw --profile haalcentraal up -d
```

This will pull the latest public release of the NL Portal backend and frontend apps alongside all the
necessary ZGW components required to demo NL Portal functionality.

The NL Portal application will be accessible at http://localhost:3000 with one of the following users:

| username | password | identifier (bsn/kvk) |
|----------|----------|----------------------|
| burger   | burger   | 999993847            |
| bedrijf  | bedrijf  | 14127293             |

**NB! The startup of all the ZGW components can take multiple minutes depending on how powerful your computer is.**

### Building and running your own apps

#### Requirements

The following software has to be installed to be able to use this application:

* Docker Desktop

#### Steps

The Docker Compose file also provides an option to build your own app images and run them should you make changes to the
Backend and/or Frontend app e.g. changing the colors and logo in the Frontend app or customizing features.

Follow these steps after doing your modifications to the sources by running the command in your terminal or
command-line:

   ```shell
   docker compose --profile local --profile zgw --profile haalcentraal up -d --build
   ```

The NL Portal application will be accessible at http://localhost:3000 with one of the following users:

| username | password | identifier (bsn/kvk) |
|----------|----------|----------------------|
| burger   | burger   | 999993847            |
| bedrijf  | bedrijf  | 14127293             |

**NB! The startup of all the ZGW components can take multiple minutes depending on how powerful your computer is.**

### Running from source

Both the backend and frontend apps can also be run from source, giving a much faster and easier development cycle.
Starting up the gradle bootrun and/or vite dev app as is will fail due to a conflict in port mapping with the
`localhost` service, thus a manual intervention is required:

* in the [docker-compose.yaml](docker-compose.yaml) file, make sure the app port mappings are commented out under the
  `localhost` service:
  ```yaml
  #          - "8080:8080" # NL Portal Backend port
  #          - "8000:8000" # NL Portal Backend debug port
  #          - "3000:8081" # NL Portal Frontend port
  ```

After doing that you can proceed to compose up the services required for you and
run both apps from sources using your favourite IDE with the gradle `bootRun` task for the backend and the
`pnpm -C frontend dev`
command for the frontend via the shell/terminal.

## Connecting to your own services

### Via envinronemnt varibales

The provided app and compose file is configured to work alongside the provided ZGW components and microservices.
You can run the NL Portal App against your own existing microservices/authentication/database by uncommenting and
changing the relevant environment variables in the following files:

* [nl-portal-app-backend environment variables](imports/backend.env)
* [nl-portal-app-frontend environment variables](imports/frontend.env)

### Via the Configuration Panel

The demo compose application also provides the option to run and use the NL Portal Configuration Panel for configuring
the NL Portal App images at runtime. This can probe really useful if you want to use your own ZGW stack, but don't want
to configure everything via environment variables.

To make use of the Configuration Panel, either add the `config` profile to any of the above-mentioned compose commands
or run the following command in your terminal separately:

```shell
docker compose --profile config up -d
```

The configuration panel will be accessible at http://localhost:3001 with the user:password `admin:admin`

## Backend Configuration Reference

The backend is configured via `imports/backend.env`. Variables follow Spring Boot relaxed binding:
`nl-portal.config.zakenapi.properties.url` → `NLPORTAL_CONFIG_ZAKENAPI_PROPERTIES_URL`

### Module Enable Flags

| Module | Variable | Default |
|--------|----------|---------|
| Zaken API | `NLPORTAL_CONFIG_ZAKENAPI_ENABLED` | false |
| Catalogi API | `NLPORTAL_CONFIG_CATALOGIAPI_ENABLED` | false |
| Besluiten API | `NLPORTAL_CONFIG_BESLUITENAPI_ENABLED` | false |
| Documenten APIs | `NLPORTAL_CONFIG_DOCUMENTENAPIS_ENABLED` | false |
| Objecten API | `NLPORTAL_CONFIG_OBJECTENAPI_ENABLED` | false |
| OpenKlant 2 | `NLPORTAL_CONFIG_OPENKLANT2_ENABLED` | false |
| HaalCentraal BRP | `NLPORTAL_CONFIG_HAALCENTRAAL2_ENABLED` | false |
| HaalCentraal HR | `NLPORTAL_CONFIG_HAALCENTRAAL_HR_ENABLED` | false |
| Berichten | `NLPORTAL_CONFIG_BERICHTEN_ENABLED` | false |
| Taak | `NLPORTAL_CONFIG_TAAK_ENABLED` | false |
| Product | `NLPORTAL_CONFIG_PRODUCT_ENABLED` | false |
| Prefill | `NLPORTAL_CONFIG_PREFILL_ENABLED` | false |
| DMN | `NLPORTAL_CONFIG_DMN_ENABLED` | false |
| OpenProduct | `NLPORTAL_CONFIG_OPENPRODUCT_ENABLED` | false |
| Payment Ogone | `NLPORTAL_CONFIG_PAYMENT_OGONE_ENABLED` | false |
| Payment Direct | `NLPORTAL_CONFIG_PAYMENT_DIRECT_ENABLED` | false |
| ClamAV Virus Scan | `NLPORTAL_CONFIG_VIRUSSCAN_CLAMAV_ENABLED` | false |

See `imports/backend.env` for all available options with inline documentation.

## Frontend Configuration Reference

The frontend is configured via `imports/frontend.env`. Variables are injected into `window.*` at runtime.

### Key Settings

| Setting | Variable | Default |
|---------|----------|---------|
| GraphQL Endpoint | `GRAPHQL_URI` | - |
| REST Endpoint | `REST_URI` | - |
| OIDC URL | `OIDC_URL` | - |
| OIDC Realm | `OIDC_REALM` | - |
| OIDC Client ID | `OIDC_CLIENT_ID` | - |
| Idle Session Logout | `OIDC_AUTO_IDLE_SESSION_LOGOUT` | true |
| Idle Timeout (minutes) | `OIDC_IDLE_TIMEOUT_MINUTES` | 15 |
| Message Count Polling | `MESSAGE_COUNT_ENABLE` | true |
| Polling Interval (ms) | `MESSAGE_COUNT_POLLING_INTERVAL` | 10000 |

See `imports/frontend.env` for all available options with inline documentation.

## Releases and Versioning

A release of this app bundles two independently versioned libraries:

* Backend version: `version` in `backend/gradle.properties`
* Frontend version: `version` in `frontend/package.json`

Git release tags combine both with an app revision: `{backend}_{frontend}-{revision}`, e.g. `3.0.3_3.0.2-1`.

### Container image tags

On a push to a `release/*` branch, each image is published with four tags:

* `{version}-{revision}` (e.g. `3.0.3-1`) — immutable, points to exactly one build. Use this to pin deployments.
* `{version}` (e.g. `3.0.3`) — floating, repointed to the latest revision of that version. Use this to automatically receive app-level fixes.
* `{major}.{minor}` (e.g. `3.0`) — floating, repointed to the latest release of that minor version. Use this to automatically receive patches within a minor.
* `{major}` (e.g. `3`) — floating, repointed to the latest release of that major version. Use this to automatically receive all fixes and features within a major.

There is no `latest` tag; pin one of the tags above instead.

### The revision number

The revision lives in `revision.properties` at the repository root and identifies app-level changes (e.g. Dockerfile or security fixes) that are released without a library version change. Both images share the same revision.

* **Bump the revision** when re-releasing with unchanged library versions.
* **Reset the revision to 1** when either library version is upgraded.

### When updating versions

When bumping a library version or the revision, also update the image tags of the `*-remote` services in `docker-compose.yaml` to the latest released version.
