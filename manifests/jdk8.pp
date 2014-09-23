# == Class: oraclejava::jdk8 
#
# install oracle java jdk 8 
# 
#

class oraclejava::jdk8 (
  $java            = 'jdk-8u20',
  $java_loc        = '/usr/java',
  $java_dir        = 'jdk1.8.0_20',
  $download_url    = 'http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz',
  $download_dir    = "/tmp",
  $cookie          = 'oraclelicense=accept-securebackup-cookie'
)
{

 file { "$java_loc":
     ensure => "directory",
     owner => 'root',
     group => 'root',
     mode => 755,
 }
 
  exec {'remove_download_oracle_jdk8':
    command     => "rm -f $download_dir/$java-linux-x64.tar.gz?*",
    cwd         => "$download_dir",
    require     => File["$java_loc"]
 } 
 
 exec { 'download_oracle_jdk8':
  command     => "wget --no-cookies --no-check-certificate --header \"Cookie: $cookie\" \"$download_url\"",
  creates     => "$download_dir/$java-linux-x64.tar.gz",
  cwd         => "$download_dir",
  timeout     => 0, 
  require     => Exec['remove_download_oracle_jdk8']
} 

 exec { 'rename_oracle_jdk8':
  command     => "mv $java-linux-x64.tar.gz?* $java-linux-x64.tar.gz",
  creates     => "$download_dir/$java-linux-x64.tar.gz",
  cwd         => "$download_dir",
  require    => Exec['download_oracle_jdk8']
} 

 file { "$download_dir/$java-linux-x64.tar.gz":
     ensure => "present",
	 owner => "root",
     group => "root",
     mode => 750,
	 require  => Exec['rename_oracle_jdk8']
 }  

  exec { 'explode_oracle_jdk8':
  command     => "tar xvf $java-linux-x64.tar.gz",
  creates     => "$download_dir/$java_dir",
  cwd         => "$download_dir",
  require    => [File["$download_dir/$java-linux-x64.tar.gz"],File["$java_loc"]]
} 

file { "$java_loc/$java_dir":
     ensure => "present",
	 owner => "root",
     group => "root",
     mode => 755,
	 source => "$download_dir/$java_dir",
	 recurse => "true",
     require => Exec["explode_oracle_jdk8"]
 }

exec { 'link_jar8':
  command     => "ln -s $java_loc/$java_dir/bin/jar /usr/bin/jar",
  creates     => '/usr/bin/jar',
  cwd         => '/usr/bin',
  require    => File["$java_loc/$java_dir"]
} 

exec { 'link_java8':
  command     => "ln -s $java_loc/$java_dir/bin/java /usr/bin/java",
  creates     => '/usr/bin/java',
  cwd         => '/usr/bin',
  require    => File["$java_loc/$java_dir"]
} 
 
exec { 'link_javac8':
  command     => "ln -s $java_loc/$java_dir/bin/javac /usr/bin/javac",
  creates     => '/usr/bin/javac',
  cwd         => '/usr/bin',
  require    => File["$java_loc/$java_dir"]
} 

exec { 'link_javadoc8':
  command     => "ln -s $java_loc/$java_dir/bin/javadoc /usr/bin/javadoc",
  creates     => '/usr/bin/javadoc',
  cwd         => '/usr/bin',
  require    => File["$java_loc/$java_dir"]
} 

exec { 'link_javaws8':
  command     => "ln -s $java_loc/$java_dir/bin/javaws /usr/bin/javaws",
  creates     => '/usr/bin/javaws',
  cwd         => '/usr/bin',
  require    => File["$java_loc/$java_dir"]
} 

exec { 'link_jcontrol8':
  command     => "ln -s $java_loc/$java_dir/bin/jcontrol /usr/bin/jcontrol",
  creates     => '/usr/bin/jcontrol',
  cwd         => '/usr/bin',
  require    => File["$java_loc/$java_dir"]
} 	

}