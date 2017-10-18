define pacman::key (
  String $keyid = $title,
  Optional[String] $keyserver = $::pacman::params::default_keyserver,
  Optional[String] $url = undef,
  Optional[String] $source = undef,
) {
  unless $keyid =~ /^0x([A-F0-9]{2}){4,20}$/ {
    fail("Invalid keyid: Please specify in the format of \"0x1234ABCD\"...")
  }
  unless $keyid =~ /^0x[A-F0-9]{40}$/ {
    warn("For security reasons it's highly recommended to use a full 40 digit keyid")
  }
  if $keyserver =~ Undef and $url =~ Undef and $source =~ Undef {
    fail('Please specify $url, $keyserver or $source')
  }
  if $source {
    $key_path = "${::pacman::params::gpgdir}${keyid}.asc"
    file { "$key_path":
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0600',
      source => $source,
    } ->
    exec { "pacman-key: add keyid $keyid":
      command => "/usr/bin/pacman-key --add $key_path",
      unless  => "/usr/bin/pacman-key --finger $keyid",
      notify  => Exec["pacman-key: locally sign keyid $keyid"],
    }
  }
  elsif $url {
    exec { "pacman-key: add keyid $keyid":
      command => "/bin/sh -c '/usr/bin/curl -SLl \"$url\" | /usr/bin/pacman-key --add -'",
      unless  => "/usr/bin/pacman-key --finger $keyid",
      notify  => Exec["pacman-key: locally sign keyid $keyid"],
    }
  }
  else {
    exec { "pacman-key: add keyid $keyid":
      command => "/usr/bin/pacman-key --keyserver $keyserver --recv-keys $keyid",
      unless  => "/usr/bin/pacman-key --finger $keyid",
      notify  => Exec["pacman-key: locally sign keyid $keyid"],
    }
  }
  exec { "pacman-key: locally sign keyid $keyid":
    command => "/usr/bin/pacman-key --lsign-key $keyid",
    unless  => "/usr/bin/pacman-key --list-sigs $keyid | grep -q '^sig   L'",
    require => Exec["pacman-key: add keyid $keyid"],
  }

  Class['::pacman::install'] ->
    Pacman::Key[$title] ->
    Class['::pacman::config']
  
  Pacman::Key[$title] ->
    Anchor['pacman::end']
}
