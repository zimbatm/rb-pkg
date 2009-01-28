# NOTE: do not require directly, it won't work

require 'yaml'

module SelfPkg
  # TODO: reload on file change
  class YAMLVFS
    def initialize(__file__)
      data = File.read(__file__).gsub(/.*\n__END__\n/m, '')
      @data = YAML.load(data)
    end

    # FIXME: raise if file not found
    def [](key); @data[key] end
    def list; @data.keys end
  end

  VFS2CLASS[:yaml] = YAMLVFS
end
