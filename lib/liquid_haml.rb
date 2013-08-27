require 'liquid_haml/version'
require 'liquid_haml/engine'

module LiquidHaml
  class Config < OpenStruct; end

  def self.config
    @config ||= Config.new
  end
end
