include epel

class {"utils": require => Class["epel"]}
class {"nginx": require => Class["epel"]}
class {"php-fpm": require => Class["epel"]}
class {"php-composer": require => Class["php-fpm"]}
class {"my_postgresql": require => Class["epel"]}

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

class {"symfony": require => Class["utils", "nginx", "php-fpm", "php-composer", "my_postgresql"]}