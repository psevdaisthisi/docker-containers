# Environment and Usage
These containers and scripts were tested under macOS Big Sur (Intel)
and macOS Ventura (Apple Silicon) using GNU bash >= `v3.2.47` and Docker
Desktop 4.20.1. There's a very good chance that they also run on
Linux and Windows/WSL but I haven't tested those yet.

All containers are managed the same way, except where noticed otherwise:
- To build the image and volume: `./do build <service>`
- To create and start the container: `./do start <service>`
- To stop container: `./do stop <service>` or `<C-c>` in the shell of a
  started container.
- To remove container and volume: `./do reset <service>`
- To remove container, volume and image: `./do rm <service>`
- To use a different service version: `VERSION=3.10.24 ./do ...`
- To force a different architecture: `ARCH=x86_64 ./do ...`
- To use a different prefix for Docker artifacts: `PREFIX=myown ./do ...`
  - The default prefix is `gh`.

## Why use bash scripts instead of Docker Compose?
- Easily _scriptable_ across major platforms (Linux, macOS, Windows/WSL).
- Natively targeting different CPU architectures and/or images under the
  same recipe.

## Attention
If you're using any of these containers in any other scenario than
your own host, grep the credentials inside the respective folders and
change them. This repository is public so bad actors can easily pick them
up at any time.


# Containers

## Microsoft SQL Server
- Available at `./mssql`.
- Microsoft SQL Server setup for both arm64 and x86\_64 architectures.
- Current arm64 version: `Azure SQL Edge 1.*`.
- Current x86\_64 version: `2019-CUXX-ubuntu-20.04`.
- Credentials: `sa`, `mssql!42`.

## MongoDB
- Available at `./mongo`.
- Minimal MongoDB container with single-node Replica Set configuration.
- Supports both arm64 and x86\_64 architectures.
- Current version is `4.4.*`.
- Admin credentials: `dba`, `dba`.
- User credentials: `dbu`, `dbu`.
- Replica Set name: `rs0`.
- Users and the Replica Set are automatically configured on the first run.
- The version can't be easily changed on demand because the deployment
  structure has changed.

## PostgreSQL
- Available at `./pgsql`.
- Supports both arm64 and x86\_64 architectures.
- Current version is `15.3-alpine3.18`.
- Credentials: `postgres`, `pgsql!42`.

## RabbitMQ
- Available at `./rmq`.
- RabbitMQ container with management interface enabled.
- Supports both arm64 and x86\_64 architectures.
- Current version is `3.11.*`.
- Credentials: `guest`, `guest`.