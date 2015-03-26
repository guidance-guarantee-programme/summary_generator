class StatusController < ApplicationController
  skip_before_action :authenticate

  def show
    head :ok
  end
end
