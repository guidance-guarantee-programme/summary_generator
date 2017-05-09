# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Error pages', type: :request do
  describe 'when the resource does not exist' do
    before { User.create }

    specify 'a routing error is raised' do
      expect do
        get '/non-existent-resource'
      end.to raise_error(ActionController::RoutingError)
    end
  end
end
