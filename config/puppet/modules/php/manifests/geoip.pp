define php::geoip {

  /* get the GeoIP data file from http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz */

  $geoipDatUrl = "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz"

  exec { "update-geoip":
    command => "/usr/bin/curl $geoipDatUrl | zcat > /usr/share/GeoIP/GeoLiteCity.dat",
    require => Package["php5-geoip"]
  }
}