include epel

class {"utils": require => Class["epel"]}
class {"nginx": require => Class["epel"]}
class {"php-fpm": require => Class["epel"]}
class {"php-composer": require => Class["php-fpm"]}
class {"postgresql":}

# Base firewall setup
resources { "firewall":
    purge => true
}
Firewall {
    before  => Class['my_fw::post'],
    require => Class['my_fw::pre'],
}
class { ['my_fw::pre', 'my_fw::post']: }
class { 'firewall': }