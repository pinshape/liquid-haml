class LiquidHaml::TemplateRenderController < ApplicationController
  def render_template
    template_path  = params[:path]
    scope = JSON.parse(params[:scope] || '{}')
    locals = JSON.parse(params[:locals] || '{}') 
    layout = params[:layout] || false

    scope.each  do |k, v|
      v = Hashie::Mash.new(v) if v.is_a?(Hash)
      self.instance_variable_set(:"@#{k}", v)
    end
    
    locals.symbolize_keys!.each do |k, v|
      locals[k] = Hashie::Mash.new(v) if v.is_a?(Hash)
    end

    render :file => Rails.root.join('app', 'views', template_path), :locals => locals, :layout => layout
  end
end
