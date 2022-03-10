# Class: pacman::params
#
class pacman::params {
  case $::osfamily {
    'Archlinux' : {
      $package_ensure = 'present'
      $package_name = 'pacman'
      $config = '/etc/pacman.conf'
      # pacman config options
      $rootdir = '/'
      $dbpath = '/var/lib/pacman'
      $cachedir = '/var/cache/pacman/pkg'
      $logfile = '/var/log/pacman.log'
      $gpgdir = '/etc/pacman.d/gnupg/'
      $holdpkg = 'pacman glibc'
      $xfercommand = undef
      $cleanmethod = 'KeepInstalled'
      $architecture = 'auto'
      # pacman package options
      $ignorepkg = undef
      $noupgrade = undef
      $noextract = undef
      # pacman misc options
      $usesyslog = false
      $color = false
      $totaldownload = false
      $checkspace = true
      $verbosepkglist = false
      $paralleldownloads = undef
      # pacman sec options
      $mainsiglevel = 'Required DatabaseOptional'
      $localfilesiglevel = 'Optional'
      $remotefilesiglevel = 'Required'
      $default_keyserver = 'hkp://pool.sks-keyservers.net:11371'
    }

    default     : {
      fail("The ${module_name} module is not supported
      on an ${::osfamily} based system.")
    }
  }
}
