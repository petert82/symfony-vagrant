# Class: epel
# The EPEL repository
#
class epel {
    yumrepo { "epel":
        # baseurl => "http://dl.fedoraproject.org/pub/epel/6/$basearch",
        baseurl => "http://download.fedoraproject.org/pub/epel/${operatingsystemmajrelease}/${architecture}",
        descr => "The epel repository",
        enabled => "1",
        gpgcheck => "0",
        # gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-epel",
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-${operatingsystemmajrelease}&arch=${architecture}",
        ensure => present
    }   
}
