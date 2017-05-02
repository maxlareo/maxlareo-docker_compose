# == Class: docker_compose::install
#
# This class install Docker Compose
#
# == Parameters:
#
# [*Version*]
#   The version of Docker Compose to be installed, Default is 1.8.1
#
# [*Docker_compose_path*]
#   The full path of the Docker Compose binary file, Default /usr/local/bin
#
class docker_compose::install (

  $version             = $docker_compose::params::version,
  $docker_compose_path = $docker_compose::params::docker_compose_path,

) inherits docker_compose::params {

  ensure_packages(['curl'], {'ensure' => 'installed'})
  $docker_version_cmd = "${docker_compose_path}/docker-compose --version"
  exec { 'download-docker-compose':
    command => "curl -L https://github.com/docker/compose/releases/download/${version}/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose",
    user    => root,
    creates => '/tmp/bin/docker-compose',
    unless  => "[ $(${docker_version_cmd} | cut -d\",\" -f1 | cut -d\" \" -f3) = \"${version}\" ]",
    require => Package['curl'],
  }
  -> exec { 'move-docker-compose':
    command => "mv /tmp/docker-compose ${docker_compose_path}",
    user    => root,
    unless  => "[ $(${docker_version_cmd} | cut -d\",\" -f1 | cut -d\" \" -f3) = \"${version}\" ]",
  }
  -> file { "${docker_compose_path}/docker-compose":
    path  => "${docker_compose_path}/docker-compose",
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }
}
