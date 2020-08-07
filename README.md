# Mindustry
Super small and simple mindustry server.

## Running the server
```bash
docker run --detach --name mindustry --publish 6567:6567/tcp --publish 6567:6567/udp hetsh/mindustry
```

## Stopping the container
```bash
docker stop mindustry
```

## Creating persistent storage
```bash
MP="/path/to/storage"
mkdir -p "$MP"
chown -R 1368:1368 "$MP"
```
`1368` is the numerical id of the user running the server (see Dockerfile).

## Automate startup and shutdown via systemd
```bash
systemctl enable mindustry@<port> --now
```
The systemd unit can be found in my [GitHub](https://github.com/Hetsh/docker-mindustry) repository. Individual server instances are distinguished by host-port. By default, the systemd service assumes `/apps/mindustry/<port>` for persistent storage.

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-mindustry)). Please feel free to ask questions, file an issue or contribute to it.