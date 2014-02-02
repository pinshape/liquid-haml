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
    
    locals.symbolize_keys!.each do |k, v|
      locals[k] = ostructify(v) if v.is_a?(Hash)
    end

    # sleep 1

    render :file => Rails.root.join('app', 'views', template_path), :locals => locals, :layout => layout
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
