# create a new run stage to ensure certain modules are included first
stage { 'pre':
  before => Stage['main']
}



# add the baseconfig module to the new 'pre' run stage
class { 'baseconfig':
  stage => 'pre'
}

class { 'systemtools':
  stage => 'main'
}

# set defaults for file ownership/permissions
File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

# Configuration for PHPReboot Development box
include baseconfig
include systemtools