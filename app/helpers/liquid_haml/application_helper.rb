module LiquidHaml
  module ApplicationHelper
    def liquid_haml_config
      LiquidHaml.config
    end

    # def method_missing(name, *args, &block)
    #   binding.pry
    #   main_app.send(name, *args, &block)
    # end

    # def respond_to?(name)
    #   main_app.respond_to?(name)
    # end
  end
end
