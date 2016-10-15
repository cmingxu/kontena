---
title: Ubuntu
---

# Running Kontena on Ubuntu

- [Prerequisities](ubuntu#prerequisities)
- [Installing Kontena Master](ubuntu#installing-kontena-master)
- [Installing Kontena Nodes](ubuntu#installing-kontena-nodes)

## Prerequisities

- [Kontena Account](https://cloud.kontena.io/sign-up)

## Installing Docker Engine

Kontena requires [Docker Engine](https://docs.docker.com/engine/) to be installed on every host (master and nodes). Preferred method for installing Docker Engine is to use Docker's APT repositories:

```
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
$ echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee -a /etc/apt/sources.list.d/docker.list
$ sudo apt-get update
$ sudo apt-get install apt-transport-https ca-certificates linux-image-extra-$(uname -r) linux-image-extra-virtual
$ sudo apt-get install docker-engine=1.11.2-0~trusty
$ sudo apt-mark hold docker-engine
```

## Installing Kontena Master

Kontena Master is an orchestrator component that manages Kontena Grids/Nodes. Installing Kontena Master to Ubuntu can be done by just installing kontena-server package:

```
$ wget -qO - https://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -
$ echo "deb http://dl.bintray.com/kontena/kontena /" | sudo tee -a /etc/apt/sources.list
$ sudo apt-get update
$ sudo apt-get install kontena-server
```

At the end of the installation the process master will ask for a initial admin code for the master. This is used to authenticate the initial admin connection of Kontena cli to properly configure the master. The code can be any random string.

If using automation the value can be overwritten in file `/etc/default/kontena-server-api`.

### Setup SSL Certificate

```
$ sudo stop kontena-server-haproxy
$ sudo vim /etc/default/kontena-server-haproxy

# HAProxy SSL certificate
SSL_CERT=/path/to/certificate.pem

$ sudo start kontena-server-haproxy
```

### Login to Kontena Master

After Kontena Master has provisioned you will be automatically authenticated as the Kontena Master internal administrator and the default grid 'test' is set as the current grid.

## Installing Kontena Nodes

Before you can start provisioning nodes you must first switch cli scope to a grid. A Grid can be thought as a cluster of nodes that can have members from multiple clouds and/or regions.

Switch to an existing grid using the following command:

```
$ kontena grid use <grid_name>
```

Or create a new grid using the command:

```
$ kontena grid create test-grid
```

Now you can go ahead and install kontena-agent Ubuntu package:

```
$ wget -qO - https://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -
$ echo "deb http://dl.bintray.com/kontena/kontena /" | sudo tee -a /etc/apt/sources.list
$ sudo apt-get update
$ sudo apt-get install kontena-agent
```

At the end of the installation the process agent will ask for a couple of configuration parameters:

* The address of the Kontena master. **Note:** You must use WebSocket protocol: ws or wss for secured connections
* The Grid token from the Kontena master

After installing all the agents, you can verify that they have joined a Grid:

```
$ kontena node list
```
