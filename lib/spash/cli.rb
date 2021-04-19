require 'spash'
require 'thor'
require 'fileutils'
require 'yaml'

module Spash
  class CLI < Thor
    desc 'create file or stdin', 'Create spash with file or stdin content.'
    def create(file_or_stdin = nil)
      api = Spash::API.new
      result = api.create(file_or_stdin)
      puts result
    end

    desc 'add file or stdin to spash.', 'Add file or stdin to spash page.'
    def add(spash, file_or_stdin = nil)
      puts "spash=#{spash}, file=#{file_or_stdin}"
    end

    desc 'auth', 'Authenticate spash.'
    def auth(token)
      auth_write(token)
      puts 'auth token saved.'
    end

    desc 'open', 'open browser as signed in user'
    def open
      api = Spash::API.new
      result = api.open
      puts result
    end

    desc 'debug info', 'Debug'
    def debug_info
      api = Spash::API.new
      puts api.debug_info
    end

    private
    def auth_write(token)
      Spash::Auth.new.save token
    end
  end
end
