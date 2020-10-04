exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

package { 'apache2':
  ensure => installed,
  require => Exec['apt-get update']
}

service { 'apache2':
  ensure => running,
  require => Package['apache2'],
  enable => true,     # Start on boot
}
#
# # python
# package { 'python-dev python-pip3':
#   ensure => installed,
#   require => Exec['apt-get update']
# }


# Remove the default apache site conf
file { '/etc/apache2/sites-enabled/000-default.conf':
  ensure => absent,
  require => Package['apache2'],
}

# Add custom conf
file { '/etc/apache2/sites-available/example.conf':
  require => Package['apache2'],
  notify => Service['apache2'],
  content => "<VirtualHost *:80>
    DocumentRoot /vagrant/webroot
    <Directory /vagrant/webroot/>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>"
}

# Enable site
file { '/etc/apache2/sites-enabled/example.conf':
  ensure => 'link',
  target => '/etc/apache2/sites-available/example.conf',
  require => Package['apache2'],
  notify => Service['apache2'],
}