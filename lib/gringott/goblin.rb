module Gringott

  # Goblin is a worker who writes the Memstore to disk
  class Goblin
    def initialize(dir, memstore)
      @dir      = dir
      @memstore = memstore
    end

    def self.start(vault)
      new(vault.vault_dir, vault.memstore).run
    end

    def run
      loop do
        @memstore.each do |hash_code, obj|
          filename = to_filename(hash_code)

          # If the object is deleted then delete the item from disk
          if obj.is_deleted
            File.delete(filename)
          # if the item is not accessed for last 60 seconds then delete the item 
          # from the memstore, for the next read the item will be moved back to 
          # memstore after reading from the disk.
          elsif obj.last_accessed_at < (Time.now + 60)
            File.write(filename, obj.value)
            obj = nil
          else
            File.write(filename, obj.value)
          end
        end

        sleep 1
      end
    end

    def to_filename(hash_code)
      "#{@dir}/#{hash_code}"
    end
  end
end