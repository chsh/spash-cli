require "spash"
require "thor"

module Spash
  class CLI < Thor
    desc "create {snake_case_string}", "convert {snake_case_string} to {camelCaseString}"
    def camelize(str)
      puts str.split("_").map{|w| w[0] = w[0].upcase; w}.join
    end

    desc "add {CamelCaseString}", "convert {CamelCaseString} to {snake_case_string}"
    def snake(str)
      puts str
             .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
             .gsub(/([a-z\d])([A-Z])/, '\1_\2')
             .tr("-", "_")
             .downcase
    end
  end
end
