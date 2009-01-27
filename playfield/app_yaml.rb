$:.unshift('../lib')
require 'selfpkg'
SelfPkg.mode(__FILE__, :yaml)

data = SelfPkg[__FILE__]
puts "Dir listing:"
puts "------------"
puts data.list
puts

puts "Show moo.css:"
puts "-------------"
puts data["moo.css"]
__END__
--- 
moo.css: !binary |
  AGRsZA==

a: hello world
