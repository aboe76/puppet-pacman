# Class: pacman::config
#
# This module manages pacman config file
#
# Parameters:
# $config = '/etc/pacman.conf'
#
# Actions:
# with the use of concat it will build a pacman config file
# which is extendable with the class pacman::repo
#
# Requires: see Modulefile
#
# Sample Usage:
#
class pacman::config (
  $config             = $pacman::config,
  # pacman config options
  $rootdir            = $pacman::rootdir,
  $dbpath             = $pacman::dbpath,
  $cachedir           = $pacman::cachedir,
  $logfile            = $pacman::logfile,
  $gpgdir             = $pacman::gpgdir,
  $holdpkg            = $pacman::holdpkg,
  $xfercommand        = $pacman::xfercommand,
  $cleanmethod        = $pacman::cleanmethod,
  $usedelta           = $pacman::usedelta,
  $architecture       = $pacman::architecture,
  # pacman package options
  $ignorepkg          = $pacman::ignorepkg,
  $noupgrade          = $pacman::noupgrade,
  $noextract          = $pacman::noextract,
  # pacman misc options
  $usesyslog          = $pacman::usesyslog,
  $color              = $pacman::color,
  $totaldownload      = $pacman::totaldownload,
  $checkspace         = $pacman::checkspace,
  $verbosepkglist     = $pacman::verbosepkglist,
  # pacman sec options
  $mainsiglevel       = $pacman::mainsiglevel,
  $localfilesiglevel  = $pacman::localfilesiglevel,
  $remotefilesiglevel = $pacman::remotefilesiglevel,) inherits pacman {
  concat { $config:
    ensure_newline => true,
    owner => 0,
    group => 0,
    mode  => '0644',
  }

  concat::fragment { 'main':
    target  => $config,
    content => template('pacman/pacman.conf.main.erb'),
    order   => 00
  }

  pacman::repo { 'core':
    include => '/etc/pacman.d/mirrorlist',
    order   => 10,
  }

  pacman::repo { 'extra':
    include => '/etc/pacman.d/mirrorlist',
    order   => 11,
  }

  pacman::repo { 'community':
    include => '/etc/pacman.d/mirrorlist',
    order   => 12,
  }

  concat::fragment { 'custom':
    target  => $config,
    content => template('pacman/pacman.conf.customrepo.erb'),
    order   => 15
  }

}
