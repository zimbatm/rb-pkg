$:.unshift('../lib')
require 'selfpkg'

data = SelfPkg[__FILE__]
puts data.list

