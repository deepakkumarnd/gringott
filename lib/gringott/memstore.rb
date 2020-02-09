module Gringott
  # Memstore is a data strucure which respond to get,set and delete methods
  # the store is a simple hash now and can be replaced for performance.
  class Memstore < Hash
    def get(key)
      self[key]
    end

    def set(key, value)
      self[key] = value
    end

    def delete(key)
      super(key)
    end
  end
end