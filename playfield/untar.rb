# Simple tar implementation, no USTAR extension or anything
# Doesn't handle mode, uid, gid, and links 

# Header: (not USTAR)
# Field Offset	Field Size	Field
# 0	100	File name
# 100	8	File mode
# 108	8	Owner user ID
# 116	8	Group user ID
# 124	12	File size in bytes (octal)
# 136	12	Last modification time
# 148	8	Check sum for header block
# 156	1	Link indicator
# 157	100	Name of linked file
#
# TODO: everything
# TODO: checksum type?

require 'fileutils'

module Kernel
  # Utils
  
  RECORD_SIZE = 512
  NAME_SIZE = 100
  
  def untar(file)
    io = file.kind_of?(IO) ? file : File.open(file)
    size = 0
    name = nil
    data = ""
    while chunk = io.sysread(RECORD_SIZE)
      if !name
        # in header
        h = chunk.split(/\0+/)
        unless h.size > 0
          exit
        end
        name = h[0]
        size = eval h[4]
      else
        # collect data
        data = data + chunk[0,size-1]
        size -= chunk.size
        if size <= 0
          # EOF, write file
          FileUtils.mkdir_p File.dirname(name)
          File.open(name, 'w') do |f|
            f.write data
          end
          name = nil
        end
      end
    end
  end
end

if __FILE__ == $0
  untar('moo.tar')
end