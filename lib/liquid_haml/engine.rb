require 'rubygems'
require 'rails'
require 'haml'
require 'jquery-rails'

module LiquidHaml
  class Engine < ::Rails::Engine
    # Override semi-isolate the namespace (keep helpers and urls herlpers as they are)
    # For the time being it just snips the last two +define_method+s from the c&ped definition
    # but it works as it should.
    def self.isolate_namespace(mod)
      engine_name(generate_railtie_name(mod))

      self.routes.default_scope = { module: ActiveSupport::Inflector.underscore(mod.name) }
      self.isolated = true

      unless mod.respond_to?(:railtie_namespace)
        name, railtie = engine_name, self

        mod.singleton_class.instance_eval do
          define_method(:railtie_namespace) { railtie }

          unless mod.respond_to?(:table_name_prefix)
            define_method(:table_name_prefix) { "#{name}_" }
          end

          unless mod.respond_to?(:use_relative_model_naming?)
            class_eval "def use_relative_model_naming?; true; end", __FILE__, __LINE__
          end
        end
      end
    end

    isolate_namespace LiquidHaml
  end
end
