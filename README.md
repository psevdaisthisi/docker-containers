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
  - The default prefix is `gh`.

# Containers

## Microsoft SQL Server
- Available at `./mssql/`.
- SQL Server setup for both arm64 and x86\_64 architectures.
- Current supported version is for arm64 is `mcr.microsoft.com/azure-sql-edge:1.0.7`.
- Current supported version is for x86\_64 is `mcr.microsoft.com/mssql/server:2019-CU20-ubuntu-20.04`.
- Credentials: `sa`, `mssql-1234`.


## MongoDB
- Available at `./mongodb`.
- Minimal MongoDB container with single-node Replica Set configuration.
- Should support both arm64 and x86\_64 architectures.
- Current supported version is `4.4.x`.
- Admin credentials: `dba`, `dba`.
- User credentials: `dbu`, `dbu`.
- Users are automatically configured on the first run.
- The version can't be easily changed on demand because the deployment
  structure has changed.

## RabbitMQ
- Available at `./rabbitmq`.
- RabbitMQ container with management interface enabled.
- Should support both arm64 and x86\_64 architectures.
- Current supported version is `3.11.x`.
- Credentials: `guest`, `guest`.