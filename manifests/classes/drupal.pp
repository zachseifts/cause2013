class drupal {
    apache::vhost { $fqdn:
        priority => 10,
        port => 80,
        docroot => "/var/www/${fqdn}",
        docroot_owner => 'www-data',
        docroot_group => 'www-data',
    }

    mysql::db { 'drupal':
        user => 'drupal',
        password => 'drupal',
        host => 'localhost',
        grant => ['all']
    }

    cron { 'drupal cron':
        command => "/usr/bin/drush -r ${fqdn} cron >/dev/null",
        user => www-data,
        minute => 0,
        require => [Exec['install drush'], Host[$fqdn]]
    }
}

