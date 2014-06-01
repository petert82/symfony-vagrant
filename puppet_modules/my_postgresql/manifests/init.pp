class my_postgresql {
    yumrepo { "pgdg93":
        # http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
        baseurl => "http://yum.postgresql.org/9.3/redhat/rhel-${operatingsystemmajrelease}-${architecture}",
        enabled => 1,
        gpgcheck => 0,
    }
    package { "postgresql93-server": ensure => installed, require => Yumrepo["pgdg93"] }
    
    exec { "create-user":
        command => "/bin/su postgres -c '/usr/pgsql-9.3/bin/createuser --superuser deploy' || true",
    }
      
    exec { "init-db":
        command => "/sbin/service postgresql-9.3 initdb",
        require => Package["postgresql93-server"],
        unless => "/bin/su postgres -c '/usr/pgsql-9.3/bin/pg_ctl status -D /var/lib/pgsql/9.3/data'",
    }
    
    Service["postgresql-9.3"] {
        start   => "/sbin/service postgresql-9.3 start",
        status  => "/sbin/service postgresql-9.3 status",
        stop    => "/sbin/service postgresql-9.3 stop",
        restart => "/sbin/service postgresql-9.3 restart",
    }
      
    service { "postgresql-9.3":
        ensure => running,
        require => [Exec["create-user"], Exec["init-db"]],
    }
    
    user { "postgres":
        ensure => present,
        require => Package["postgresql93-server"],
    }
}