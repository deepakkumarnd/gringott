require 'objspace'
require 'gringott/memstore'

module Gringott

  # A vault is where the data is stored, it is analogous to a bucket of key value pairs
  class Vault

    attr_reader :key_count

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
      @memstore.get(key)
    end

    def delete(key)
      return 'Error' if @memstore[key].nil?

      @memstore.delete(key)
      @key_count -= 1
      'OK'
    end
  end
end