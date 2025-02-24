# NordVPN

ATTENTION: Requires NordVPN subscription to make use of any utilities on this project.

This project is a collection of utilities to help you manage your NordVPN connection. VPN connections affects the entire system, so this help you capsulate the VPN connection to a specific application with Docker.

## Getting Started

All the utilities are referring to the NordVPN Docker image, which run the NordVPN daemon and provide a way to connect to their VPN servers.
You need to build the image first before you start using the utilities.

Assuming you run following command in the `nordvpn` directory of this project.

```bash
make build
```

If you only make use of NordVPN, you can use the built image directly.

Running the image requires some special privileges to configure the network settings.
A shorthand script is available with make.

```bash
make run
```

## Utilities

- `transmission`: [Transmission](https://transmissionbt.com/) BitTorrent daemon over NordVPN connection.
- `tinyproxy`: [Tinyproxy](https://tinyproxy.github.io/) HTTP/HTTPS proxy server over NordVPN connection.

All of the utilities are using Docker Compose to manage the services.
You can start the services with following command.

```bash
docker-compose build
docker-compose up -d
```

## Known Issues

### WSL

If you are using WSL, you may need to re-build kernel for the NordVPN to work.
You need to turn on `CONFIG_NETFILTER_XT_MATCH_CONNMARK` in your kernel configuration.