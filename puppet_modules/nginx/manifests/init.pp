# Class: nginx
#
#
class nginx {
    package { "nginx":
        ensure => installed,
        before => Service["nginx"]
    }
    
    service { "nginx":
        enable => true,
        ensure => running,
        #hasrestart => true,
        #hasstatus => true,
    }
}