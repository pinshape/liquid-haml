class LiquidHaml::TemplateRenderController < ApplicationController
  def render_template
    template_path  = params[:path]
    scope = params[:scope] || {}
    locals = params[:locals] || {}
    layout = params[:layout] || false

    scope.each  do |k, v|
      v = ostructify(v) if v.is_a?(Hash)
      self.instance_variable_set(:"@#{k}", v)
    end
    locals.each do |k, v|
      locals[k] = ostructify(v) if v.is_a?(Hash)
    end

    render :file => Rails.root.join('app', 'views', 'application/other_test'), :locals => locals, :layout => layout
  end

  private
    module HashToOpenstruct
      require 'ostruct'

      def to_ostruct
        o = OpenStruct.new(self)
        each.with_object(o) do |(k,v), o|
          class << v; include HashToOpenstruct; end if v.is_a?(Hash)
          o.send(:"#{k}=", v.to_ostruct) if v.respond_to? :to_ostruct
        end
        o
      end
    end

    def ostructify(what)
      class << what; include HashToOpenstruct; end
      what.to_ostruct
    end
end