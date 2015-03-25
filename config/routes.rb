Rails.application.routes.draw do
  root 'appointment_summaries#new'

  resources :appointment_summaries, only: %i(new create)

  mount GovukAdminTemplate::Engine, at: '/style-guide'

  scope path: 'styleguide', controller: 'styleguide' do
    scope path: 'pages' do
      get 'input', action: 'pages_input'
      get 'output-elements', action: 'pages_output_elements'
      get 'output-custom', action: 'pages_output_custom'
      get 'output-generic', action: 'pages_output_generic'
      get 'output-ineligible', action: 'pages_output_ineligible'
    end

    get '(/:action)'
  end
end
