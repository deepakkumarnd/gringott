require 'objspace'
require 'gringott/memstore'

module Gringott

  # A vault is where the data is stored, it is analogous to a bucket of key value pairs
  class Vault

    attr_reader :key_count, :memstore

    def initialize(name)
      @memstore = Memstore.new
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

    def vault_dir
      "#{@v_name}.vt"
    end

    def bytes_in_memory
      # Could be a slow operation
      ObjectSpace.memsize_of(@memstore)
    end

    def set(key, value)
      old_value = @memstore.get(key)

      if old_value.nil?
        @memstore.set(key, value)
        @key_count += 1
        'OK'
      elsif old_value != value
        @memstore.set(key, value)
      end
    end

    def get(key)
      value = @memstore.get(key)

      if value.nil?
        hash_code = @memstore.to_hash_code(key)
        if File.exist?("#{vault_dir}/#{hash_code}")
          value = File.read("#{vault_dir}/#{hash_code}")
          set(key, value)
        end
      end

      value
    end

    def delete(key)
      return 'Error' if @memstore.get(key).nil?

      @memstore.delete(key)
      @key_count -= 1
      'OK'
    end
  end
end