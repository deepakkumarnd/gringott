require 'singleton'

module Gringott

  # Vault manager manages Gringott we call the cheif manager as Griphook
  class VaultManager
    include Singleton

    attr_reader :current_vault

    def use_vault(vault_name)
      @current_vault = Vault.new(vault_name)
    end

    def drop_vault(vault_name)
      raise CommandError, "Error, cannot drop the current vault" if vault_name == @current_vault.vault_name

      FileUtils.rm_r("#{vault_name}.vt") if File.directory?("#{vault_name}.vt")
    end

    def create_vault(vault_name)
      if Dir.exist?("#{vault_name}.vt") || File.exist?("#{vault_name}.vt")
        raise CommandError, "Vault `#{vault_name}` already exists."
      end

      FileUtils.mkdir "#{vault_name}.vt"
      'OK'
    end

    def list_vaults
      Dir.entries('.')
        .select { |d| File.directory?(d) && (d =~ /.*.vt\z/) }
    end

    # Data manipulation commands
    def get(key)
      vault_selected!
      @current_vault.get(key)
    end

    def set(key, value)
      vault_selected!
      @current_vault.set(key, value)
    end

    def delete(key)
      vault_selected!
      @current_vault.delete(key)
    end

    def stats
      vault_selected!
      {
        vault_name: @current_vault.vault_name,
        keys: @current_vault.key_count,
        bytes_in_memory: @current_vault.bytes_in_memory
      }
    end

    private

    def vault_selected!
      if @current_vault.nil?
        raise CommandError, 'Error, please choose a vault with `use` command'
      end
    end
  end

  # Griphook is the chief vault manager for Gringott and is head of goblins
  Griphook = VaultManager.instance
end