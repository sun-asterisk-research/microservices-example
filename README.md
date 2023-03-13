# Sample Microservices Application

This project is a simple blog in microservices with Kubernetes, GraphQL and gRPC. The blog is a web app where users can register/login, browse stories, comment, write stories and add them to their collections.

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

- K8s cluster required (Minikube, .etc)
- Clone this repo

### Run containers

```bash
skaffold run
```

### Dev mode

If you want to start containers & watch for sourcecode changes for development. Use the `dev` command instead of `skaffold run`:

```bash
skaffold dev -p dev
```

### Setup Hasura

```bash
# cd src/hasura
hasura metadata apply
hasura migrate apply
```

### Custom domain

```
0.0.0.0 hasura.local blog.local
```
