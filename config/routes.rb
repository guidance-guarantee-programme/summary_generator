Rails.application.routes.draw do
  root 'appointment_summaries#new'

  resources :appointment_summaries, only: %i(new create)

  mount GovukAdminTemplate::Engine, at: '/style-guide'

  scope path: 'styleguide', controller: 'styleguide' do
    scope path: 'pages' do
      get 'input', action: 'pages_input'
    end

    get '(/:action)'
  end
end
