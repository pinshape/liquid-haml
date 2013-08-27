class LiquidHaml::TemplateRenderController < ApplicationController
  def render_template
    template_path  = params[:path]
    scope = JSON.parse(params[:scope] || '{}')
    locals = JSON.parse(params[:locals] || '{}') 
    layout = params[:layout] || false

    scope.each  do |k, v|
      v = ostructify(v)
      self.instance_variable_set(:"@#{k}", v)
    end
    locals.each do |k, v|
      locals[k] = ostructify(v) if v.is_a?(Hash)
    end

    render :file => Rails.root.join('app', 'views', template_path), :locals => locals, :layout => layout
  end

  # def method_missing(name, *args, &block)
  #   puts "got method: #{name}"
  #   super
  # end

  protected
    # def _routes
    #   main_app
    # end

    # def _helpers

    # end

    def url_options
      options = super
      binding.pry
      options
    end

    def self.view_context_class
      context_class = super
      context_class.send(:include, Rails.application.routes.url_helpers)
      binding.pry
      context_class
    end

    def _render_template(options)
      lookup_context.rendered_format = nil if options[:formats]

      a = view_context
      binding.pry
      path = a.items_path

      view_renderer.render(view_context, options)
    end

  private
    require 'ostruct'

    def ostructify(what)
      case what
        when Hash
          ostructed = OpenStruct.new(what)
          what.each do |k,v|
            ostructed.send(:"#{k}=", ostructify(v))
          end
        when Array
          ostructed = what.map { |elem| ostructify(elem) }
        else
          ostructed = what
      end

      ostructed
    end
end
