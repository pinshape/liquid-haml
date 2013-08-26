Rails.application.routes.draw do
  mount LiquidHaml::Engine => '/liquid_haml'

  get 'test' => 'application#test'
  get 'other_test' => 'application#other_test'
end
