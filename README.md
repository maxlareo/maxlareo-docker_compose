# docker_compose

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with docker_compose](#setup)
    * [What docker_compose affects](#what-docker_compose-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with docker_compose](#beginning-with-docker_compose)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

A Puppet module to install and set [Docker Compose](https://docs.docker.com/compose/overview/)
files and manage Docker containers through Docker Compose commands.

### Support

This module is currently tested on:

* Debian Jessie

## Module Description

The docker_compose manage Docker Compose Files and Docker containers through them.

This module generate docker-compose.yml files conform to the official
[Docker Documentation](https://docs.docker.com/compose/compose-file/).

## Setup

### What docker_compose affects

* Curl present to download Docker Compose binary.
* Docker Compose binary installed on the node.
* Docker Compose files in `${name}/docker-compose.yml`.

### Setup Requirements

This module requires Docker to be installed and running.
It also require [puppetlabs-stdlib](https://github.com/puppetlabs/puppetlabs-stdlib).

### Beginning with docker_compose

#### Install Docker Compose

```puppet
class { 'docker_compose': }
```

If using Hiera
```yaml
---
classes:
  - docker_compose
```

#### Docker Compose example

```puppet
docker_compose::compose { '/opt':
  version  => '2',
  services => {
    'hello-world' => {
      image => 'hello-world'
    },
  },
}
```

If using Hiera
```yaml
docker_compose::compose:
  '/opt':
    version: '2'
    services:
      hello-world:
        image: hello-world
```

On the node, in the '/opt' folder, try `docker-compose run hello-world` to test it.

## Usage

To declare a docker-compose file, use the docker_compose::compose resource.
This resource use nested Hashes to describe each docker-compose.yml files.

The first Hash layer use the key as the path of the docker-compose file.
The option `version` is mandatory and describe the docker compose syntax version.
The rest is optional and try to follow the
[Docker Documentation](https://docs.docker.com/compose/compose-file/)
syntax, using four options: services, volumes, networks and secrets.

A service definition contains configuration which will be applied to each container
started for that service, much like passing command-line parameters to docker run.
Likewise, network and volume definitions are analogous to docker network create and
docker volume create.

Secrets configuration are availble from Docker Compose version 3 and grant access to
secrets on a per-service basis using the per-service secrets.

### Example of bare minimum to create a Docker Compose file

For a file to be created, only the hash key and the version has to be setted.

Create a docker-compose.yml file in '/opt':
```puppet
docker_compose::compose { '/opt':
  version  => '2',
}
```
If using Hiera
```yaml
docker_compose::compose:
  '/opt':
    version: '2'
```

### Declare services / volumes / networks / secrets

Services, Volumes, Networks and Secrets are declared into a Hash,
following the Docker Compose file syntax.

Declarations example of some services:
```puppet
docker_compose::compose { '/opt':
  version  => '2',
  services => {
    'nginx' => {
      image => 'nginx:latest',
      container_name: 'nginx'
    },
    'mariadb' => {
      image => 'mariadb'
    },
  },
}
```

If using Hiera
```yaml
docker_compose::compose:
  '/opt':
    version: '2'
      services:
        nginx:
          image: nginx
          container_name: nginx
        mariadb:
          image: mariadb
```

### Full Example

Here is a full example of docker-compose file declarations with this module:
```puppet
docker_compose::compose { '/opt':
  version  => '2',
  services => {
    nginx => {
      image => 'nginx:latest',
      container_name => 'nginx',
      networks => [ 'net-1' ],
      ports => [ '80:80','443:443' ],
      volumes => [ 'web:/var/www/html' ]
    },
    mariadb => {
      image => 'mariadb'
    },
  },
  volumes => {
    web => {},
  },
  networks => {
    net-1 => {
      ipam => {
        config => [
          { subnet => '172.50.1.0/24' }
        ],
      }
    },
  },
}
```

If using Hiera
```yaml
docker_compose::compose:
  '/opt':
    version: '2'
    services:
      nginx:
        image: 'nginx'
        container_name: 'nginx'
        networks:
          - 'net-1'
        ports:
          - '80:80'
          - '443:443'
        volumes:
          - 'web:/var/www/html'
      mariadb:
        image: 'mariadb'
    volumes:
      web:
    networks:
      net-1:
        ipam:
          config:
            - subnet: '172.50.2.0/24'
```

## Reference

### Public Class

* docker_compose

### Private Class

* docker_compose::install
* docker_compose::params

### Define

* docker_compose::compose

#### Class  ̀docker_compose ̀

Parameters

* version
The version of Docker Compose to be installed.
String. Default: 1.8.1

* docker_compose_path
The docker-compose binary full path.
String. Default: /usr/local/bin

#### Define  ̀docker_compose::compose ̀

Parameters

* version
The docker-compose syntax version use into the file.
String. Default: 2

* owner
The owner of the docker-compose file.
String. Default: root

* group
The group of owner the docker-compose file.
String. Default: root

* ensure
The puppet ensure state of the docker-compose file.
String. Default: present

* services
The docker services describe into the docker-compose file.
Hash. Default: undef

* volumes
The docker volumes describe into the docker-compose file.
Hash. Default: undef

* networks
The docker networks describe into the docker-compose file
Hash. Default: undef

* secrets
The docker secrets describe into the docker-compose file
Hash. Default: undef

## Limitations

This module is tested on Debian 8 and should work on every
Debian based distribution.

For now only installation and files creation and management of
Docker Compose are supported.

Further functionalities to come:

* management of docker containers through docker-compose commands.
For example, maintain "docker-compose up -d" or set "docker-compose down".
* possibility to auto pull docker containers from docker-compose via cron.
To maintain latest docker images running.

## Development

Contributions will be gratefully accepted. Please go to the project page, fork the project, make your changes locally and then raise a pull request. Details on how to do this are available at https://guides.github.com/activities/forking.
