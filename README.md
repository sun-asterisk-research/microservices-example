# Sample Microservices Application

This project is a simple blog in microservices with Kubernetes, GraphQL and gRPC. The blog is a web app where users can register/login, browse stories, comment, write stories and add them to their collections.

## Architecture

| Service        | Language | Description                                  |
| -------------- | -------- | -------------------------------------------- |
| web            | Node.js  | Serve the website for the end-users          |
| hasura         | Haskell  | API Gateway & GraphQL API                    |
| account        | Go       | Store the accounts                           |
| authentication | Go       | Login to the blog with the given credentials |
| contents-view  | Node.js  | Render markdown contents to HTML             |
| search         | Rust     | Search the stories / authors                 |

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
