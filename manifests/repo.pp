# This resource manages an individual repo's that applies to the file defined in
# $target. See README.md for more details.
# always order from 100 and increase.
define pacman::repo (
  $server      = undef,
  $include     = undef,
  $description = undef,
  $siglevel    = undef,
  $order       = '100',
  # Needed for testing primarily, support for multiple files is not really
  # working.
  $target      = $pacman::config::config) {
  # Create a rule fragment
  $fragname = "repo_${name}"

  concat::fragment { $fragname:
    target  => $target,
    content => template('pacman/pacman.conf.repo.erb'),
    order   => $order,
  }
}
