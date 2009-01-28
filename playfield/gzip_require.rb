require 'tmpdir'
require 'zlib'

module Kernel
  # Loads a gzip-compressed file as a ruby source. Removes ruby header if 
  # present
  #
  # We use an intermediate file instead of evalin so that
  #  __FILE__ is well defined.
  #
  # FIXME: behave like require
  # TODO: merge with require
  def gzip_require(file_path)
    if $LOADED_FEATURES.include? file_path
      return false
    end

    # Load data and remove ruby header
    data = File.open(file_path).read.gsub(/.*\n__END__\n/m,'')   

    tmp_path = File.join Dir.tmpdir, File.basename(file_path)

    File.open( tmp_path, 'w' ) do |f|
      f.write Zlib::Inflate.inflate data
    end
    load tmp_path

    $LOADED_FEATURES.push file_path
    return true
  end
end