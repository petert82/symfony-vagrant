class my_postgresql {
    yumrepo { "pgdg93":
        # http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
        baseurl => "http://yum.postgresql.org/9.3/redhat/rhel-${operatingsystemmajrelease}-${architecture}",
        enabled => 1,
        gpgcheck => 0,
    }
    package { "postgresql93-server": 
        ensure => installed, 
        require => Yumrepo["pgdg93"],
        before  => Class['postgresql::server']
    }->
    # This is here because I could not get 'initdb_path' in the globals class to work
    exec { "init-db":
        command => "/sbin/service postgresql-9.3 initdb",
        require => Package["postgresql93-server"],
        unless => "/bin/su postgres -c '/usr/pgsql-9.3/bin/pg_ctl status -D /var/lib/pgsql/9.3/data'",
    }->
    # https://forge.puppetlabs.com/puppetlabs/postgresql
    class { 'postgresql::globals':
        encoding => 'UTF8',
        locale   => 'en_US.UTF-8',
        service_name => "postgresql-9.3",
        createdb_path => "/usr/bin/createuser",
        psql_path => "/usr/bin/psql",
        needs_initdb => false,
    }->
    class { 'postgresql::server':
        locale                  => 'en_US.UTF-8',
        ipv4acls                => ['local all all md5'],
    }->
    postgresql::server::role { 'vagrant':
      createdb      => true,
      login         => true,
      password_hash => postgresql_password("vagrant", "vagrant"),
    }
}