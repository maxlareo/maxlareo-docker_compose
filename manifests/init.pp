# == Class: docker_compose
#
# This module install and set Docker Compose
#
# == Parameters:
#
# [*Version*]
#  The version of Docker Compose to be installed, Default is 1.8.1
#
# == Documentation
#
class docker_compose (
  $compose = {},
) inherits docker_compose::params {

  require 'stdlib'

  contain 'docker_compose::install'

  create_resources('docker_compose::compose', $compose)

}
