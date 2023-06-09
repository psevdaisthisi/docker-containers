Notes:
- Minimal MongoDB container with single-node Replica Set configuration.
- Should support both arm64 and x86\_64 architectures.
- Current supported version is `4.4.x`.
- Admin credentials: `dba`, `dba`.
- User credentials: `dbu`, `dbu`.
- Users are automatically configured on the first run.

Usage:
- To build the image: `./lets build`
- To create and start the container: `./lets run`
- To stop container: `./lets stop`
- To remove container and volume: `./lets reset`
- To remove container, volume and image: `./lets rm`