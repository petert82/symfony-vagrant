# Class: nginx
#
#
class nginx {
    package { "nginx":
        ensure => installed,
        before => Service["nginx"]
    }->
    file { "/etc/nginx/nginx.conf":
        source => "puppet:///modules/nginx/nginx.conf",
        ensure => file,
        notify => Service["nginx"]
    }~>
    service { "nginx":
        enable => true,
        ensure => running,
        #hasrestart => true,
        #hasstatus => true,
    }
    
    firewall { '100 allow http and https access':
        port   => [80, 443],
        proto  => tcp,
        action => accept,
    }
}