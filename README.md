# Usage
All containers are managed the same way, except where noticed otherwise:
- To build the image: `./<service>/do build`
- To create and start the container: `./do run`
- To stop container: `./<service>/do stop`
- To remove container and volume: `./<service>/do reset`
- To remove container, volume and image: `./<service>/do rm`
- To use a different service version: `VERSION=3.10.24 ./<service>/do ...`
- To force a different architecture: `ARCH=x86_64 ./<service>/do ...`
- To use a different prefix for Docker artifacts: `PREFIX=myown ./<service>/do ...`
  * The default prefix is `gh`.

## Attention
If you're using using any of these containers in any other scenario than
your own host, grep the credentials inside the respective folders change
them. This repository is public so bad actors can easily pick these up
to automatically try them later.


# Containers

## Microsoft SQL Server
- Available at `./mssql`.
- Microsoft SQL Server setup for both arm64 and x86\_64 architectures.
- Current arm64 version: `mcr.microsoft.com/azure-sql-edge:1.0.7`.
- Current x86\_64 version: `mcr.microsoft.com/mssql/server:2019-CU20-ubuntu-20.04`.
- Credentials: `sa`, `mssql-1234`.

## MongoDB
- Available at `./mongodb`.
- Minimal MongoDB container with single-node Replica Set configuration.
- Supports both arm64 and x86\_64 architectures.
- Current supported version is `4.4.x`.
- Admin credentials: `dba`, `dba`.
- User credentials: `dbu`, `dbu`.
- Users are automatically configured on the first run.
- The version can't be easily changed on demand because the deployment
  structure has changed.

## PostgreSQL
- Available at `./pgsql`.
- Supports both arm64 and x86\_64 architectures.
- Current supported version is `15.3-alpine3.18`.
- Credentials: `postgres`, `pgsql!42`.

## RabbitMQ
- Available at `./rabbitmq`.
- RabbitMQ container with management interface enabled.
- Supports both arm64 and x86\_64 architectures.
- Current supported version is `3.11.x`.
- Credentials: `guest`, `guest`.