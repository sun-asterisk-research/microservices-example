# microservices-example

This project is a simple blog in microservices with Kubernetes, GraphQL and gRPC. The blog is a web app where users can register/login, browse stories.

## Architecture

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
- [DevSpace](https://www.devspace.sh/)
- Clone this repo

### Run containers with DevSpace

```bash
$ devspace deploy
```

### Dev mode

If you want to start containers & watch for sourcecode changes for development. Use the `dev` command instead of `devspace deploy`:

```bash
$ devspace dev
```

At the first run, DevSpace will build base image, you can skip this action at next run by

```shell
$ devspace dev --skip-build
```

### Setup Hasura

Install [Hasura CLI](https://hasura.io/docs/latest/hasura-cli/install-hasura-cli/)

```shell
curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash
```

Port-forwarding Hasura to your local machine for using Hasura CLI:

```bash
devspace open
```

Run from host machine:

```bash
# cd src/hasura
hasura metadata apply --admin-secret <secret>
hasura migrate apply --admin-secret <secret>
hasura seed apply --admin-secret <secret>
```

### Custom domain

```
0.0.0.0 hasura.blog.local blog.local
```
