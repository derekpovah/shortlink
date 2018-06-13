Rails.application.routes.draw do
  resources :shortlinks
  get '/:shortlink' => 'redirect#index'
end
