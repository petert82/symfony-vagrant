# Class: php-fpm
#
#
class php-fpm {
    package { "php-fpm":      ensure => installed, before => Service["php-fpm"] }
    package { "php-pdo":      ensure => installed, before => Service["php-fpm"] }
    package { "php-pgsql":    ensure => installed, before => Service["php-fpm"] }
    package { "php-pecl-apc": ensure => installed, before => Service["php-fpm"] }
    package { "php-mbstring": ensure => installed, before => Service["php-fpm"] }
    package { "php-intl":     ensure => installed, before => Service["php-fpm"] }
    package { "php-xml":      ensure => installed, before => Service["php-fpm"] }
    
    service { "php-fpm":
        enable => true,
        ensure => running,
        #hasrestart => true,
        #hasstatus => true,
        # require => Package["php-fpm", "php-pdo", "php-pgsql", "php-pecl-apc", ],
    }
    
    file { "/etc/php.ini":
        source => "puppet:///modules/php-fpm/php.ini",
        ensure => file,
        notify => Service["php-fpm"]
    }
    file { "/etc/php-fpm.conf":
        source => "puppet:///modules/php-fpm/php-fpm.conf",
        ensure => file,
        notify => Service["php-fpm"]
    }
    file { "/etc/php-fpm.d/www.conf":
        source => "puppet:///modules/php-fpm/www.conf",
        ensure => file,
        notify => Service["php-fpm"]
    }
}