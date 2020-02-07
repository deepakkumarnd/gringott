require 'objspace'

module Gringott

  # A vault is where the data is stored, it is analogous to a bucket of key value pairs
  class Vault

    # Creates a vault and returns 'OK'
    def self.create(name)
      if Dir.exist?("#{name}.vt") || File.exist?("#{name}.vt")
        raise CommandError, "Vault `#{name}` already exists."
      end

      FileUtils.mkdir "#{name}.vt"
      'OK'
    end

    attr_reader :key_count

    def initialize(name)
      @memstore = {}
      @key_count = 0

      if Dir.exist? "#{name}.vt"
        @v_name = name
      else
        raise CommandError, "Vault `#{name}` does not exist."
      end
    end

    def vault_name
      @v_name
    end

    def bytes_in_memory
      # Could be a slow operation
      ObjectSpace.memsize_of(@memstore)
    end

    # Drops a vault and returns OK
    def drop
      FileUtils.rm_r("#{@v_name}.vt") if File.directory?("#{@v_name}.vt")
      'OK'
    end

    def set(key, value)
      @memstore[key] = value
      @key_count += 1
      'OK'
    end

    def get(key)
      @memstore[key]
    end

    def delete(key)
      @memstore.delete(key)
      @key_count -= 1
      'OK'
    end
  end
end