**This Project is still work in progress.**

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
The systemd unit can be found in my GitHub [repository](https://github.com/Hetsh/docker-mindustry).
```bash
systemctl enable mindustry@<port> --now
```
Individual server instances are distinguished by host-port.
By default, the systemd service assumes `/apps/mindustry/<port>` for persistent storage and `/etc/localtime` for timezone.
Since this is a personal systemd unit file, you might need to adjust some parameters to suit your setup.

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-mindustry)).
Please feel free to ask questions, file an issue or contribute to it.