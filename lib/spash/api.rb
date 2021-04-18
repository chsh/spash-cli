module Spash
  class API
    def config
      @config ||= load_config
    end
    def auth_token
      Spash::Auth.new.load
    end

    def create(text = nil)
      if text.nil?
        raise "no stdin input" unless STDIN.tty?
        text = $stdin.read
      end

    end

    def debug_info
      { config: config }
    end

    private
    def post(text)
    end

    def save_auth_token(token)
      config_path = "#{ENV['HOME']}/.spash"
      FileUtils.mkdir_p config_path
      FileUtils.chmod 'go-rwx', config_path
      File.open("#{config_path}/config.yml", 'w') do |f|
        yaml = {'auth' => token}.to_yaml
        f.write yaml
      end
    end

    def load_auth_token
      load_config['auth']
    end

    def load_config
      config_path = "#{ENV['HOME']}/.spash"
      config_path = "#{config_path}/config.yml"
      raise 'No config file found.' unless File.exist?(config_path)

      config = YAML.load_file(config_path)
      raise 'No auth entry for config.file.' unless config['auth']

      config
    end
  end
end
