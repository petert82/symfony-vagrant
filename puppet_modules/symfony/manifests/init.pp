# Class: symfony
#
#
class symfony {
    file { "/etc/nginx/conf.d/default.conf":
        source => "puppet:///modules/symfony/default.conf",
        ensure => file,
        # notify => Service["nginx"]
    }
}