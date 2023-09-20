# microservices-example

This project is a simple blog in microservices with Kubernetes, GraphQL and gRPC. The blog is a web app where users can register/login, browse stories.

## Architecture

See [diagram](./architecture.png):

| Service                 | Language | Technical stack       | Description                                        |
| ----------------------- | -------- | --------------------- | -------------------------------------------------- |
| hasura                  | Haskell  | GraphQL               | API Gateway, Authentication, Authorization, access |
| web-app                 | Node.js  | React                 | Serve the website for the end-users                |
| account-service         | Go       | gRPC server           | Register account & sign-in, accounts management    |
| account-subgraph        | Rust     | GraphQL server        | Remote schema for hasura (gRPC to GraphQL)         |
| views-count-service     | Rust     | gRPC server           | Increment story view                               |
| views-count-subgraph    | Rust     | gRPC client / GraphQL | Remote schema for hasura (gRPC to GraphQL)         |
| recommendation-service  | Go       | gRPC server           | Recommend related-stories, authors                 |
| recommendation-subgraph | Go       | gRPC client / GraphQL | Recommend related-stories, authors                 |
| contents-view-subgraph  | Node.js  | TypeScript            | Render markdown contents to HTML                   |

## Quickstart

- K8s cluster required (Minikube, k3s, .etc)
- [DevSpace](https://www.devspace.sh/) installed
- Clone this repo

Deploy this project on your local cluster:

```bash
devspace deploy -p local
```

Now you can open:

- http://localhost:8787 : Web application
- http://localhost:8080 : Hasura console

Please use the following command:

```bash
devspace open
```

## Development

This project uses Devspace's Dependencies feature for building and developing microservices. Each project is defined as a dependency project. It allows running one or a few microservices instead of all.

```bash
devspace dev --dependency hasura,web-app
```

### Dev mode

If you want to start containers & watch for sourcecode changes for development. Use the `dev` command instead of `devspace deploy`:

```bash
devspace dev --dependency hasura,web-app
```

At the first run, DevSpace will build base image, you can skip this action at next run by

```shell
devspace dev --skip-build
```

Resync source files for running dev containers:

```bash
devspace sync --config devspace.yaml --upload-only
```

### Setup Hasura

If `src/hasura/**` folder contains files change. You need to import Hasura metadata and migrations.

Please run the following command:

```bash
# Access the Hasura CLI container:
devspace enter -l app=hasura -c cli

# Import metadata:
hasura-cli metadata apply

# Apply database migrations:
hasura-cli migrate apply --all-databases

# Seeding data:
hasura-cli metadata reload
hasura-cli seed apply --all-databases
```
