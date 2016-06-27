# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Status page', type: :request do
  describe 'GET /status' do
    it 'returns an empty 200 OK response to indicate that the app is running' do
      get '/status'

      expect(response).to be_ok
    end
  end
end
