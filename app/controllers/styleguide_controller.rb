class StyleguideController < ApplicationController
  def index
  end

  def base
  end

  def pages_input
    render template: 'styleguide/pages/input'
  end

  def pages_input_v2
    render template: 'styleguide/pages/input_v2'
  end
end
