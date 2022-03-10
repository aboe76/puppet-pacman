# Class: pacman
#
# This module manages pacman
#
# Parameters:
# $config = '/etc/pacman.conf'
# $config_template = 'pacman/pacman.conf.archlinux.erb'
# $package_name = ['pacman']
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class pacman (
  $config             = $pacman::params::config,
  $package_ensure     = $pacman::params::package_ensure,
  $package_name       = $pacman::params::package_name,
  # pacman config options
  $rootdir            = $pacman::params::rootdir,
  $dbpath             = $pacman::params::dbpath,
  $cachedir           = $pacman::params::cachedir,
  $logfile            = $pacman::params::logfile,
  $gpgdir             = $pacman::params::gpgdir,
  $holdpkg            = $pacman::params::holdpkg,
  $xfercommand        = $pacman::params::xfercommand,
  $cleanmethod        = $pacman::params::cleanmethod,
  $architecture       = $pacman::params::architecture,
  # pacman package options
  $ignorepkg          = $pacman::params::ignorepkg,
  $noupgrade          = $pacman::params::noupgrade,
  $noextract          = $pacman::params::noextract,
  # pacman misc options
  $usesyslog          = $pacman::params::usesyslog,
  $color              = $pacman::params::color,
  $totaldownload      = $pacman::params::totaldownload,
  $checkspace         = $pacman::params::checkspace,
  $verbosepkglist     = $pacman::params::verbosepkglist,
  $paralleldownloads  = $pacman::params::paralleldownloads,
  # pacman sec options
  $mainsiglevel       = $pacman::params::mainsiglevel,
  $localfilesiglevel  = $pacman::params::localfilesiglevel,
  $remotefilesiglevel = $pacman::params::remotefilesiglevel,) inherits
pacman::params {
  include '::pacman::install'
  include '::pacman::config'

  anchor { 'pacman::begin': }

  anchor { 'pacman::end': }

  Anchor['pacman::begin'] ->
    Class['::pacman::install'] ->
    Class['::pacman::config'] ->
    Anchor['pacman::end']
}
