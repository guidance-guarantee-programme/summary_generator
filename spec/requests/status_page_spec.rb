require 'rails_helper'

RSpec.describe 'Status page', type: :request do
  shared_examples 'status page' do
    describe 'GET /status' do
      it 'returns an empty 200 OK response to indicate that the app is running' do
        get '/status'

        expect(response).to be_ok
      end
    end
  end

  context 'with authentication disabled' do
    include_examples 'status page'
  end

  context 'with authentication enabled' do
    before do
      DigestAuthentication.initialize(Rails.application.root.join('features/support/users.csv'))
    end

    include_examples 'status page'
  end
end
