# == Class: docker_compose
#
# This module install and set Docker Compose
#
# == Parameters
#
# [*version*]
#   String. Mandatory. Default: 1.8.1
#   The version of Docker Compose to be installed
#
# [*docker_compose_path*]
#   String. Mandatory. Default: /usr/local/bin
#   The docker-compose binary full path
#
# [*compose*]
#   Hash. Optional. Default: undef
#   The complete docker-compose.yml file configuration (nested) hash
#   If an hash is provided here, docker_compose::compose defines are declared with:
#   create_resources('docker_compose::compose', $compose)
#
# == Requires
#
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
class docker_compose (
  $compose = {},
  $version = $::docker_compose::params::version,
  $docker_compose_path = $::docker_compose::params::docker_compose_path,
) inherits docker_compose::params {

  require 'stdlib'

  contain 'docker_compose::install'

  create_resources('docker_compose::compose', $compose)

}
