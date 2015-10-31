# Class: deploy
#
# This module manages deploy
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class deploy {
  #dados do projeto
  $projeto = hiera('projectName')
  $url_repo = hiera('urlrepo')
  
  #dados da versão do sistema
  $artefato = hiera('artifact')
  $versao = hiera('version')
  $extensao = hiera('extensions')
  
#  #envio do arquivo .war
#  exec{"downloadprojeto":
#    command => "wget -P $repositorio/$projeto http://site.war",
#    path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
#    refreshonly => true,
#    
#    
#  }
  file{"/home/$projeto/$artefato":
    ensure => present,
    mode => '0644',
    owner => root,
    group => root
  }
  
  file{"/home/$projeto/$artefato/$artefato-$versao.$extensao":
    ensure => present,
    source => "puppet///modules/repositorio/$projeto/site.war"
  }
  
  file{"/home/$projeto/web":
    ensure => link,
    target => "/home/$projeto/$artefato",
    mode => '0644',
    owner => root,
    group => root
  }
  exec{"deploy":
    command => "",
    path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    refreshonly => true,
    notify => Service["tomcat"]
  }
}
