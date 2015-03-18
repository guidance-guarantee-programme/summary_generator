require 'rails_helper'

RSpec.describe OutputDocument do
  let(:title) { 'Mr' }
  let(:first_name) { 'Joe' }
  let(:last_name) { 'Bloggs' }
  let(:output_document) { described_class.new(appointment_summary) }
  let(:appointment_summary) do
    instance_double(AppointmentSummary,
                    title: title,
                    first_name: first_name,
                    last_name: last_name,
                    date_of_appointment: Date.today,
                    value_of_pension_pots: 35_000,
                    income_in_retirement: :pension,
                    guider_name: 'A Guider',
                    guider_organisation: 'tpas')
  end

  let(:customer_name) { "#{title} #{first_name} #{last_name}" }

  describe '#html' do
    subject { output_document.html }

    it { is_expected.to include(customer_name) }
  end

  describe '#pdf' do
    subject { PDF::Inspector::Text.analyze(output_document.pdf).strings.join }

    it { is_expected.to include(customer_name) }
  end
end
