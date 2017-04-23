# == Define: docker_compose::compose
#
# With this define you can manage a docker-compose file
#
# == Parameters:
#
# #https://docs.docker.com/compose/compose-file/
define docker_compose::compose (
  $version     = '2',
  $owner       = 'root',
  $group       = 'root',
  $ensure      = 'present',
  $services     = [],
  $networks     = [],
  $volumes      = [],
  $secrets      = [],
) {

  validate_array($services)
  validate_array($networks)
  validate_array($volumes)
  validate_array($secrets)

  file { "$name/docker-compose.yml":
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    content => template("docker_compose/docker-compose.yml.erb")
  }

}
