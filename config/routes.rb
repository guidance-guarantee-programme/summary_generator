Rails.application.routes.draw do
  root 'appointment_summaries#new'

  constraints format: 'html' do
    resources :appointment_summaries, only: %i(new create)

    scope path: 'styleguide', controller: 'styleguide' do
      scope path: 'pages' do
        get 'input', action: 'pages_input'
      end

      get '(/:action)'
    end

    get '/status', to: 'status#show'

    mount GovukAdminTemplate::Engine, at: '/style-guide'
  end
end
