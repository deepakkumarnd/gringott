module Gringott

  # A vault is where the data is stored, it is analogous to a bucket of key value pairs
  class Vault

    def self.create(name)
      if Dir.exist?("#{name}.vt") || File.exist?("#{name}.vt")
        raise CommandError, "Vault `#{name}` already exists."
      end

      FileUtils.mkdir "#{name}.vt"
    end

    def self.list
      Dir.entries('.')
        .select { |d| File.directory?(d) && (d =~ /.*.vt\z/) }
    end

    def initialize(name)
      if Dir.exist? "#{name}.vt"
        @v_name = name
      else
        raise CommandError, "Vault `#{name}` does not exist."
      end
    end

    def drop
      FileUtils.rm_r("#{@v_name}.vt") if File.directory?("#{@v_name}.vt")
    end
  end
end