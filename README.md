# Mindustry
Super small and simple vanilla mindustry server.

## Running the server
```bash
docker run --detach --interactive --name mindustry --publish 6567:6567/tcp --publish 6567:6567/udp hetsh/mindustry
```
`--interactive` enables passing commands to the running server (required for shutdown).

## Stopping the container
```bash
echo stop | docker attach mindustry
```
Because the mindustry server does not catch the `SIGTERM` signal that is sent by `docker stop`, we have to gracefully shut down the server by piping the `stop` command to container.

## Creating persistent storage
```bash
MP="/path/to/storage"
mkdir -p "$MP"
echo "eula=true" > "$MP/eula.txt"
chown -R 1368:1368 "$MP"
```
`1368` is the numerical id of the user running the server (see Dockerfile).
Start the server with the additional mount flag:
```bash
docker run --mount type=bind,source=/path/to/storage,target=/mindustry ...
```

## Automate startup and shutdown via systemd
```bash
systemctl enable mindustry@<port> --now
```
The systemd unit can be found in my [GitHub](https://github.com/Hetsh/docker-mindustry) repository. Individual server instances are distinguished by host-port. By default, the systemd service assumes `/srv/mindustry_<port>` for persistent storage.

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-mindustry)). Please feel free to ask questions, file an issue or contribute to it.