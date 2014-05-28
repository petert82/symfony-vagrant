include epel

class {"utils": require => Class["epel"]}
class {"nginx": require => Class["epel"]}
class {"php-fpm": require => Class["epel"]}
class {"postgresql":}