# == Define: docker_compose::compose
#
# With this define you can manage a docker-compose file
#
# == Parameters:
#
# [*version*]
#   String. Mandatory. Default: 2
#   The docker-compose syntaxe version use into the file
#
# [*owner*]
#   String. Mandatory. Default: root
#   The owner of the docker-compose file
#
# [*group*]
#   String. Mandatory. Default: root
#   The group of owner the docker-compose file
#
# [*ensure*]
#   String. Mandatory. Default: present
#   The puppet ensure state of the docker-compose file
#
# [*services*]
#   Hash. Optional. Default: undef
#   The docker services describe into the docker-compose file
#   Refer to Documentaion for further description
#
# [*volumes*]
#   Hash. Optional. Default: undef
#   The docker volumes describe into the docker-compose file
#   Refer to Documentaion for further description
#
# [*networks*]
#   Hash. Optional. Default: undef
#   The docker networks describe into the docker-compose file
#   Refer to Documentaion for further description
#
# [*secrets*]
#   Hash. Optional. Default: undef
#   The docker secrets describe into the docker-compose file
#   Refer to Documentaion for further description
#
# == Documentation:
#
# https://docs.docker.com/compose/compose-file/
#
define docker_compose::compose (
  $version     = '2',
  $owner       = 'root',
  $group       = 'root',
  $ensure      = 'present',
  $services    = {},
  $volumes     = {},
  $networks    = {},
  $secrets     = {},
) {

  validate_hash($services)
  validate_hash($volumes)
  validate_hash($networks)
  validate_hash($secrets)

  file { "$name/docker-compose.yml":
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    content => template("docker_compose/docker-compose.yml.erb")
  }

}
