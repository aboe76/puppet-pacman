# Class: pacman::install
#
# This class ensures pacman is installed
#
class pacman::install (
  $package_ensure = $pacman::package_ensure,
  $package_name   = $pacman::package_name,) inherits pacman {
  package { 'pacman':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
