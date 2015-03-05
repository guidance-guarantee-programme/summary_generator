Rails.application.routes.draw do
  root 'appointment_summaries#new'

  constraints format: 'html' do
    resources :appointment_summaries, only: %i(new create)

    scope path: 'styleguide', controller: 'styleguide' do
      scope path: 'pages' do
        get 'input', action: 'pages_input'
        get 'input-v2', action: 'pages_input_v2'
      end

      get '(/:action)'
    end

    mount GovukAdminTemplate::Engine, at: '/style-guide'
  end
end
