#!/usr/bin/env ruby
%w{tmpdir fileutils yaml}.each{|f|require f};class File;f=__FILE__
p=join Dir.tmpdir,f+".unpack";FileUtils.rm_rf p;YAML.load(read(f).gsub /.*\n__END__\n/m,"").
each_pair{|k,v|q=join p,k;FileUtils.mkdir_p dirname(q);open(q,"w"){|x|x<<v}end end
__END__
