#!/usr/bin/env ruby
require"zlib";require"tmpdir";class File;f=__FILE__;d=read(f).gsub /.*\n__END__\n/m,""
p=join Dir.tmpdir,basename(f);open(p,"w"){|f|f<<Zlib::Inflate.inflate(d)};load p end
__END__
