module Spash
  class Auth
    def initialize(config = nil)
      @config = config || Spash::Config.new
    end
    attr_reader :config

    def save(token)
      config.put(:auth, token)
    end

    def load
      config.get(:auth) || raise('Auth token not stored.')
    end
  end
end
