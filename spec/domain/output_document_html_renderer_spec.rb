# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OutputDocument::HTMLRenderer do
  describe '#render' do
    shared_examples 'renders html' do |variant|
      context "with a '#{variant}' output document" do
        let(:output_document) do
          attributes = {
            attendee_address: '1 Horse Guard Road',
            variant: variant,
            format_preference: 'standard',
            appointment_type: 'standard'
          }

          instance_double(OutputDocument, attributes).as_null_object
        end

        let(:html_renderer) { described_class.new(output_document) }

        subject { html_renderer.render }

        it do
          is_expected.to match(%r{<html.+</html>}im)
        end
      end
    end

    %w(base other).each { |variant| include_examples('renders html', variant) }
  end
end
