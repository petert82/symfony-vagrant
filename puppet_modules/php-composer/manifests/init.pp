# Class: php-composer
#
#
class php-composer {
    exec { "Install composer":
        command => "curl -s https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer",
        path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        creates => "/usr/local/bin/composer",
    }
}