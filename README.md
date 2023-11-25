# Environment and Usage
These containers and scripts were tested under macOS Ventura and Sonoma +
Docker Desktop for both Apple Silicon and Intel architectures. There's a
very good chance that they also run on Linux and Windows/WSL but I haven't
tested those yet.

All containers are managed the same way, except where noticed otherwise:
| Command | Result |
|---------|--------|
| `./lets build <container>` | Build image and volume. |
| `./lets start <container>` | Start container. |
| `./lets stop <container>` or `<C-c>` | Stop container. |
| `./lets reset <container>` | Remove container and volume. |
| `./lets rm <container>` | Remove container, volume and image. |
| `ARCH=<arm64,x86_64> ./lets ...` | Force a specifc architecture. |
| `PREFIX=<prefix> ./lets ...` | Use a different prefix for Docker artifacts.[^1] |
| `VERSION=X.Y.Z ./lets ...` | Use a different service version. |

[^1]: The default prefix is `gh`.

## Why use bash scripts instead of Docker Compose?
- Easily _scriptable_ across major platforms (Linux, macOS and WSL).
- Natively targeting different CPU architectures and/or images under the
  same recipe.

## Attention
If you're using any of these containers in any other scenario than
your own localhost, find and replace the default credentials.
This repository is public so bad actors can easily pick them up at any time.


# Containers

## Microsoft SQL Server
- `./lets start mssql`.
- Microsoft SQL Server setup for both arm64 and x86\_64 architectures.
- Current arm64 version: `Azure SQL Edge 1.*`.
- Current x86\_64 version: `2019-CUXX-ubuntu-20.04`.
- Credentials: `sa`, `mssql!42`.

## MongoDB
- `./lets build mongo`.
- `./lets start mongo`.
- Minimal MongoDB container with single-node Replica Set configuration.
- Supports both arm64 and x86\_64 architectures.
- Current version is `7.*`.
- Admin credentials: `dba`, `dba`.
- User credentials: `dbu`, `dbu`.
- Replica Set name: `rs0`.
- Users and the Replica Set are automatically configured on the first run.

## PostgreSQL
- `./lets start pgsql`.
- Supports both arm64 and x86\_64 architectures.
- Current version is `15.4-alpine3.18`.
- Credentials: `postgres`, `pgsql!42`.

## RabbitMQ
- `./lets start rmq`.
- RabbitMQ container with management interface enabled.
- Supports both arm64 and x86\_64 architectures.
- Current version is `3.11.*`.
- Credentials: `guest`, `guest`.