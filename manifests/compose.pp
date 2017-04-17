# == Define: docker_compose::compose
#
# With this define you can manage a docker-compose file
#
# == Parameters:
#
# #https://docs.docker.com/compose/compose-file/
define docker_compose::compose (

  version  = $::docker_compose::params::compose_version,
  path     = $::docker_compose::params::compose_path,
  owner    = $::docker_compose::params::compose_owner,
  group    = $::docker_compose::params::compose_group,
  ensure   = $::docker_compose::params::compose_ensure,
  services = {},
  networks = {},
  volumes  = {},
  secrets  = {},

) inherits docker_compose::params {

  validate_hash($services)
  validate_hash($networks)
  validate_hash($volumes)
  validate_hash($secrets)

  # path is a mandatory value, exit if undef
  if $path == undef {
   fail() 
  }

  file { 'docker-compose.yml':
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    path    => $path,
    content => template("docker_compose/docker-compose.yml.erb")
  }

}
