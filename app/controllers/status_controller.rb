# frozen_string_literal: true
class StatusController < ApplicationController
  skip_before_action :require_signin_permission!

  def show
    head :ok
  end
end
