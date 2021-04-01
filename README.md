# Docker Systools

Docker image with some system and network tools for troubleshooting, specially in kubernetes

## Warning and disclaimer

- This is not a secure image nor a small image, because it contains a lot of tools. This is only for troubleshooting. Use it if you know what you do.
- This Dockerfile is not cleaning at all... so it's bigger (but more useful)
- This is provided with no warranty at all.

## Supported architectures

Based on ubuntu oficial image, so supported architectures of that image (including ARM64!). Simply build it for your architecture

## What's inside

- Some **network clients**: ftp, ssh, telnet
- Some **network tools**: netstat, ifconfig, socat, nc, whois, traceroute, ping, iperf3, nslookup, nmap, tcpdump, tshark, iftop
- Some **basic editors**: nano
- Some **http tools**: curl, wget, lynx
- Some **source control clients**: git, svn
- Some **database clients**: mysql, postgresql, sqlline (jdbc command-line tool)
- Some **certificate and ssl tools**: openssl
- Some **system tools**: htop, zip, jq

## Basic usage

- **Docker command line with host network:**

    `# docker run -it --rm --name docker-systools --net host ponte124/docker-systools bash`

- **Docker command line with network capabilities:**

    `# docker run -it --rm --name docker-systools --cap-add=NET_ADMIN --cap-add=CAP_NET_RAW ponte124/docker-systools bash`

- **Docker compose example:** (first clone this repo)

    `# docker-compose up -d`
    `# docker-compose exec docker-systools bash`
    `CONTAINER# nc -zv db 3306`

- **Kubernetes (as deployment):** (first clone this repo)

    `# kubectl apply -f k8s-dksystools-deploy.yaml`
    `# kubectl exec -it docker-systools bash`

## Volumes and mounts

If you need operate with data you can mount any folder you need as a volume.

## Short examples of some utilities

NOT YET DOCUMENTED (please, contribute with your own examples)

- **Test a port:** Test if a port is open and listening

    `CONTAINER# nc -zv <server> <port>`

- **Top net traffic:**

    `CONTAINER# iftop -i <netinterface>`

- **Top containers:**

    `# docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock ponte124/docker-systools ctop

## Building or customizing the image

First clone this repo. Here there's a Makefile with some variables you can export on your term before building the image.

- ARG INCLUDE_CONTROL_VERSION=true . If set to false won't install svn, git
- ARG INCLUDE_EXTRAS_NET=true . If set to false won't install lynx, tshark and some more extras
- ARG INCLUDE_DB_CLIENTS=true . If set to false won't install mysql-client, pg-client, java, jdbc-drivers, sqlline
- ARG FINAL_CLEAN=true . If set to false won't do final APT cleaning.

Then:

- **Build:**

    `# make build`

- **Push:** You'll need first to customize registry in Makefile and login your registry

    `# make push`

## Contributions

Advices and contributions and forks and emails are welcome

## Related work

Maybe you prefer using <https://github.com/nicolaka/netshoot> or <https://github.com/Praqma/Network-MultiTool>

Why I prefer my own image if these look better? Because it's based on ubuntu (I can do whatever I want, confortably)
