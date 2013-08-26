LiquidHaml::Engine.routes.draw do
  post '/' => 'template_render#render_template'
end
