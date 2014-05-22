# Class: pacman::params
#
class pacman::params {
  case $::osfamily {
    'Archlinux' : {
      $package_ensure = 'present'
      $package_name = ['pacman']
      $config = '/etc/pacman.conf'
      # pacman config options
      $rootdir = '/'
      $dbpath = '/var/lib/pacman'
      $cachedir = '/var/cache/pacman/pkg'
      $logfile = '/var/log/pacman.log'
      $gpgdir = '/etc/pacman.d/gnupg/'
      $holdpkg = 'pacman glibc'
      $xfercommand = '/usr/bin/curl -C - -f %u > %o'
      $cleanmethod = 'KeepInstalled'
      $usedelta = '0.7'
      $architecture = 'auto'
      # pacman package options
      $ignorepkg = undef
      $noupgrade = undef
      $noextract = undef
      # pacman misc options
      $usesyslog = false
      $color = true
      $totaldownload = false
      $checkspace = true
      $verbosepkglist = false
      # pacman sec options
      $mainsiglevel = 'Required DatabaseOptional'
      $localfilesiglevel = 'Optional'
      $remotefilesiglevel = 'Required'
    }

    default     : {
      fail("The ${module_name} module is not supported
      on an ${::osfamily} based system.")
    }
  }
}
