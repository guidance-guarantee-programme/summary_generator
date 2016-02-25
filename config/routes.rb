Rails.application.routes.draw do
  root 'appointment_summaries#new'

  resources :appointment_summaries, only: %i(new create) do
    post :preview, on: :collection
  end

  scope path: 'styleguide', controller: 'styleguide' do
    scope path: 'pages' do
      get 'input', action: 'pages_input'
      get 'output-base', action: 'pages_output_base'
      get 'output-50-54', action: 'pages_output_50_54'
      get 'output-base-large', action: 'pages_output_base_large'
      get 'output-50-54-large', action: 'pages_output_50_54_large'
      get 'output-ineligible', action: 'pages_output_ineligible'
    end

    get '(/:action)'
  end

  get '/status', to: 'status#show'

  mount GovukAdminTemplate::Engine, at: '/style-guide'
end
