#puppet-pacman


####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with salt](#setup)
    * [What pacman affects](#what-pacman-affects)
    * [Beginning with pacman](#beginning-with-pacman)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)


# Pacman Puppet Module

Manage pacman configuration on archlinux


##Module Description

This module can be used to configure the pacman.conf file on Archlinux

##Setup

###What pacman affects

 * pacman.conf
 * pacman repositories
 
###Beginning with pacman

Just add manifest:

```puppet
include pacman
```

Or if you want to change params you need to include the underlying modules:
 
```puppet
class { 'pacman': }
class { 'pacman::repo': 'custom':
      description => "custom repo",
      siglevel => 'never',
      server => 'http://custom.example.com/$arch',
      order => '100',
    }
```

##Usage

All interaction with the pacman module can be done through
the main pacman class. except for adding extra repositories

###I just want the default pacman.conf, what's the minimum I need?

```puppet
include '::pacman'
```

###I just want a pacman configuration with archlinux testing repo?

Testing repo needs to be above all other repo's
the default repo's start with order number 10
so everything below is ok.

```puppet
include '::pacman'
class 'pacman::repo': 'testing':
  include => '/etc/pacman.d/mirrorlist',
  order => 09
```

###I just want a pacman configuration with a custom repo?

Custom repo's needs to be below all other repo's
Custom repo's start with order number 100

```puppet
include '::pacman'
class 'pacman::repo': 'custom':
  siglevel = 'never',
  server => 'http://custom.example.com/$arch',
  order => 100
```


##Reference

###Classes
 * pacman: Main class, includes all the rest.
 * pacman::repo: Handles the repositories.
 * pacman::config: Handles the pacman configuration
 * pacman::params: all parameters needed for the rest.


##Limitations

This module has been built on and tested against Puppet 3.6.0 and higher.
This module works only on archlinux
