# Class: symfony
#
#
class symfony {
    file { "/etc/nginx/conf.d/default.conf":
        source => "puppet:///modules/symfony/default.conf",
        ensure => file,
        # notify => Service["nginx"]
    }
    
    postgresql::server::db { 'symfony':
        user     => 'symfony',
        password => postgresql_password('symfony', 'symfonypass'),
    }->
    postgresql::server::database_grant { 'test1':
        privilege => 'ALL',
        db        => 'symfony',
        role      => 'vagrant',
    }
}