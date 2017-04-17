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

) inherits docker_compose::params {

  require stdlib

  class { 'docker_compose::install' } ->
  class { 'docker_compose::service' }

}
