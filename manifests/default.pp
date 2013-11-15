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
}

