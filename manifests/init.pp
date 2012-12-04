class dmxusb {
  #install the right kernel sources, this is a dependency
  package {
    "kernel-source-$kernelversion.slice!(-1)":
        ensure => installed,
        alias => "kernel-source"
  }

  package {
    "git-core":
        ensure => installed
  }
  
  exec {
    "download_dmx_usb_sources":
      command => "git clone git://github.com/lowlander/dmx_usb_module.git /tmp/dmx_sub",
      creates => "/tmp/dmx_usb",
      require => Package["git-core"]
  }

  exec {
    "build_dmx_usb":
      command => "cd /tmp/dmx_sub && make"
      creates => "/lib/modules/dmx_usb.ko",
      require => [Package["kernel-source"], Exec["download_dmx_usb_sources"]]
  }
}
