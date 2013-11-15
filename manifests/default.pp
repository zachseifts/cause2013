node default {
    package { php5:
        ensure => latest,
    }

    package { php-pear:
        ensure => latest,
        require => Package['php5']
    }

    package { php-console-table:
        ensure => latest,
        require => [Package['php5'], Package['php-pear']]
    }

    exec { 'install drush':
        command => '/usr/bin/pear channel-discover pear.drush.org && /usr/bin/pear install drush/drush',
        require => Package['php-console-table'],
        creates => '/usr/bin/drush'
    }

    host { 'test.cause13.local':
        ensure => 'present',
        ip => '127.0.0.1'
    }

    class { 'apache':
        default_vhost => false,
        mpm_module => 'prefork',
    }

    class { 'apache::mod::php':
        require => Package["php5"]
    }

    class { '::mysql::server':
        root_password => 'root',
    }

    apache::vhost { 'test.cause13.local':
        priority => 10,
        port => 80,
        docroot => '/var/www/test.cause13.local',
        docroot_owner => 'www-data',
        docroot_group => 'www-data',
    }

    file { '/var/www/test.cause13.local/index.php':
        ensure => 'absent',
    }
}

