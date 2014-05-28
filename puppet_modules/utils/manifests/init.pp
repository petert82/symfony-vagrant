# Class: utils
#
#
class utils {
    package { "vim":
        ensure => installed,
    }
    package { "git":
        ensure => installed,
    }
}