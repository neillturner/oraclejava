# == Class: oraclejava::jdk8_rpm 
#
# install oracle java jdk 8 rpm 
# 
#
class oraclejava::jdk8_rpm (
  $java_loc        = '/usr/java',
  $java_dir        = 'jdk1.8.0_20',
  $rpm_name        = 'jdk-8u20-linux-x64.rpm',
  $download_url    = 'http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.rpm',
  $cookie          = 'oraclelicense=accept-securebackup-cookie'
)
{

  file { "$java_loc":
     ensure => "directory",
     owner => 'root',
     group => 'root',
     mode => 755,
  }
 
  exec { 'download_oracle_jdk8_rpm':
    cwd     => "$java_loc",
    creates => "$java_loc/$rpm_name",
    command => "wget --no-cookies --no-check-certificate --header \"Cookie: $cookie\" \"${download_url}\"",
    timeout => 0,
  }

  exec { 'install_oracle_jdk8_rpm':
    cwd     => "$java_loc",
    creates => "$java_loc/$java_dir",
    command => "yum -y install \"$java_loc/$rpm_name\"",
    require  => Exec['download_oracle_jdk8_rpm'],
    timeout => 0
  }
} 
 
