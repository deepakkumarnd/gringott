require 'singleton'

module Gringott

  # Vault manager manages Gringott we call the cheif manager as Griphook
  class VaultManager
    include Singleton

    attr_reader :current_vault

    # vault is an object of class Vault
    def use_vault(vault)
      @current_vault = vault
    end
  end

  # Griphook is the chief vault manager for Gringott and is head of goblins
  Griphook = VaultManager.instance
end