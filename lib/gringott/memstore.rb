require 'digest'

module Gringott
  # Memstore is a data strucure which respond to get,set and delete methods
  # the store is a simple hash now and can be replaced for performance.

  KeyValue = Struct.new(
    :key,
    :value,
    :is_deleted,
    :last_accessed_at
  )

  # In memory key value store
  class Memstore

    def initialize
      @hashstore = {}
    end

    def get(key)
      hash_code = to_hash_code(key)

      if obj = @hashstore[hash_code]
        unless obj.is_deleted
          obj.last_accessed_at = Time.now
          obj.value
        end
      end
    end

    def set(key, value)
      hash_code = to_hash_code(key)
      @hashstore[hash_code] = KeyValue.new(key, value, false, Time.now)
    end

    def delete(key)
      hash_code = to_hash_code(key)
      (obj = @hashstore[hash_code]) && (obj.is_deleted = true)
    end

    def to_hash_code(key)
      Digest::SHA2.hexdigest(key)
    end

    def each(&block)
      @hashstore.each do |key, value|
        block.call(key, value)
      end
    end
  end
end