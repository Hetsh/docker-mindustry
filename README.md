# Mindustry
Super small and simple vanilla mindustry server.

## Running the server
```bash
docker run --detach --interactive --name mindustry --publish 6567:6567 hetsh/mindustry
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
chown -R 1357:1357 "$MP"
```
`1357` is the numerical id of the user running the server (see Dockerfile).
Mojang also requires you to accept their EULA. Honestly, you would just klick 'accept' anyway...
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