# == Class: oraclejava::jdk9
#
# install oracle java jdk 9
#
#

class oraclejava::jdk9 (
  $java_id      = 'jdk-9-ea+102',
  $java         = 'jdk-9-b102',
  $java_loc     = '/usr/java',
  $java_dir     = 'jdk1.9.0_b102',
  $download_url = 'http://www.java.net/download/jdk9/archive/102/binaries/jdk-9-ea+102_linux-x86_bin.tar.gz',
  $download_dir = '/tmp',
  $wget_opts    = '',
  $cookie       = 'oraclelicense=accept-securebackup-cookie'
)
{

  file { $java_loc:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  exec {'remove_download_oracle_jdk9':
    command => "rm -f ${download_dir}/${java}-linux-x64.tar.gz?*",
    cwd     => $download_dir,
    require => File[$java_loc]
  }

  exec { 'download_oracle_jdk9':
    command => "wget ${wget_opts} --no-cookies --no-check-certificate --header \"Cookie: ${cookie}\" \"${download_url}\"",
    creates => "${download_dir}/${java_id}-linux-x64.tar.gz",
    cwd     => $download_dir,
    timeout => 0,
    require => Exec['remove_download_oracle_jdk9']
  }

  exec { 'rename_oracle_jdk9':
    command => "mv \"${java_id}-linux-x64.tar.gz\" ${java}-linux-x64.tar.gz",
    creates => "${download_dir}/${java}-linux-x64.tar.gz",
    cwd     => $download_dir,
    require => Exec['download_oracle_jdk9']
  }

  file { "${download_dir}/${java}-linux-x64.tar.gz":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0750',
    require => Exec['rename_oracle_jdk9']
  }

  exec { 'explode_oracle_jdk9':
    command => "tar xvf ${java}-linux-x64.tar.gz",
    creates => "${download_dir}/${java_dir}",
    cwd     => $download_dir,
    require => [File["${download_dir}/${java}-linux-x64.tar.gz"],File[$java_loc]]
  }

  file { "${java_loc}/${java_dir}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => "${download_dir}/${java_dir}",
    recurse => true,
    require => Exec['explode_oracle_jdk9']
  }

  exec { 'link_jar9':
    command => "ln -s ${java_loc}/${java_dir}/bin/jar /usr/bin/jar",
    creates => '/usr/bin/jar',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_java9':
    command => "ln -s ${java_loc}/${java_dir}/bin/java /usr/bin/java",
    creates => '/usr/bin/java',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javac9':
    command => "ln -s ${java_loc}/${java_dir}/bin/javac /usr/bin/javac",
    creates => '/usr/bin/javac',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javadoc9':
    command => "ln -s ${java_loc}/${java_dir}/bin/javadoc /usr/bin/javadoc",
    creates => '/usr/bin/javadoc',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javaws9':
    command => "ln -s ${java_loc}/${java_dir}/bin/javaws /usr/bin/javaws",
    creates => '/usr/bin/javaws',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_jcontrol9':
    command => "ln -s ${java_loc}/${java_dir}/bin/jcontrol /usr/bin/jcontrol",
    creates => '/usr/bin/jcontrol',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

}
