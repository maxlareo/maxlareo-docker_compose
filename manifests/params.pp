# == Class: docker_compose::params
#
# Defines all the variables used in the module
#
class docker_compose::params {
  $version             = '1.8.1'
  $docker_compose_path = '/usr/local/bin'

  Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'] }
}
