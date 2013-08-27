require 'rubygems'
require 'rails'
require 'haml'
require 'jquery-rails'

module LiquidHaml
  class Engine < ::Rails::Engine
    isolate_namespace LiquidHaml
  end
end
