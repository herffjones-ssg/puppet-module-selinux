# == Class: selinux
#
# Manages SELinux.
#
class selinux (
  $mode = 'permissive',
  $type = 'targeted',
) {

  case $mode {
    'enforcing','permissive','disabled': {
      # noop
    }
    default: {
      fail("mode is ${mode} and must be either 'enforcing', 'permissive' or 'disabled'.")
    }
  }

  case $type {
    'targeted','strict': {
      # noop
    }
    default: {
      fail("type is ${type} and must be either 'targeted' or 'strict'.")
    }
  }

  file { 'selinux_config':
    ensure  => 'file',
    path    => '/etc/selinux/config',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('selinux/config.erb'),
  }

  # Per CIS: Ensure SETroubleshoot service is not present on the system.
  package {'setroubleshoot':
    ensure => absent,
  }
}
