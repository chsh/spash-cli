module Spash
  class Config
    def initialize
      setup_default_config_file
    end

    def get(key)
      config[key.to_s]
    end

    def put(key, value)
      config[key.to_s] = value
      save_config
      value
    end

    def config
      @config ||= load_config
    end

    private
    def setup_default_config_file
      config_dir = "#{ENV['HOME']}/.spash"
      config_path = "#{config_dir}/config.yml"
      unless Dir.exist?(config_dir)
        FileUtils.mkdir_p config_dir
        FileUtils.chmod 'go-rwx', config_dir
      end
      unless File.exist?(config_path)
        File.open("#{config_path}/config.yml", 'w') do |f|
          yaml = {}.to_yaml
          f.write yaml
        end
        FileUtils.chmod 'go-rwx', config_path
      end
    end

    def load_config
      config_path = verify_and_get_config_path
      YAML.load_file(config_path)
    end

    def save_config
      config_path = verify_and_get_config_path
      File.open(config_path, 'w') do |f|
        f.write config.to_yaml
      end
    end

    def verify_and_get_config_path
      config_dir = "#{ENV['HOME']}/.spash"
      config_path = "#{config_dir}/config.yml"
      raise "No config_dir=#{config_dir} present." unless Dir.exist?(config_dir)
      raise "No config_path=#{config_path} present." unless File.exist?(config_path)
      config_path
    end
  end
end
