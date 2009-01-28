module SelfPkg
  # Simple VFS with no directories and IO streams
  # TODO: add cache
  class StupidFlatVFS
    def initialize(__file__)
      @root_dir = File.dirname( __file__ )
    end
    # Should return a file content or raise Errno::ENOENT?
    # FIXME: securize path
    def [](key)
      File.read File.join( @root_dir, File.basename(key) )
    end
    # Should return an array of the available files
    def list
      Dir.entries(@root_dir).select{|f| File.file? f}
    end
  end

  # Package registry
  @packages = {}
  # Used to asyncly set the mode
  @package_vfs = {}
  VFS2CLASS = {:default => StupidFlatVFS}
  class << self
    def [](key)
      @packages[key] ||= (VFS2CLASS[@package_vfs[key] || :default]).new(key)
    end

    # Pre-set the VFS for the file
    def mode(__file__, mode)
      require "selfpkg/#{mode}"
      @package_vfs[__file__] = mode.to_sym
    end
  end

end
