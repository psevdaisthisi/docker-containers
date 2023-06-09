## MongoDB
Notes:
- Minimal MongoDB container with single-node Replica Set configuration.
- Should support both arm64 and x86\_64 architectures.
- Current supported version is `4.4.x`.
- Admin credentials: `dba`, `dba`.
- User credentials: `dbu`, `dbu`.
- Users are automatically configured on the first run.

Usage:
- To build the image: `./do build`
- To create and start the container: `./do run`
- To stop container: `./do stop`
- To remove container and volume: `./do reset`
- To remove container, volume and image: `./do rm`

## RabbitMQ
Notes:
- RabbitMQ container with management interface enabled.
- Should support both arm64 and x86\_64 architectures.
- Current supported version is `3.11.x`.
- Credentials: `guest`, `guest`.

Usage:
- To build the image: `./do build`
- To create and start the container: `./do run`
- To stop container: `./do stop`
- To remove container and volume: `./do reset`
- To remove container, volume and image: `./do rm`
- To use a different version: `VERSION=3.10.24 ./do ...`
- To force a different architecture: `ARCH=x86_64 ./do ...`