require 'rails_helper'

RSpec.describe OutputDocument do
  let(:title) { 'Mr' }
  let(:first_name) { 'Joe' }
  let(:last_name) { 'Bloggs' }
  let(:output_document) { described_class.new(appointment_summary) }
  let(:value_of_pension_pots) { nil }
  let(:upper_value_of_pension_pots) { nil }
  let(:params) do
    {
      title: title,
      first_name: first_name,
      last_name: last_name,
      date_of_appointment: Date.today,
      value_of_pension_pots: value_of_pension_pots,
      upper_value_of_pension_pots: upper_value_of_pension_pots,
      income_in_retirement: :pension,
      guider_name: 'A Guider',
      guider_organisation: 'tpas'
    }
  end
  let(:appointment_summary) { AppointmentSummary.new(params) }
  let(:ineligible_text) { 'ineligible' }
  let(:generic_guidance_text) { 'generic guidance' }
  let(:continue_working_text) { 'continue_working' }
  let(:unsure_text) { 'unsure' }
  let(:leave_inheritance_text) { 'leave_inheritance' }
  let(:wants_flexibility_text) { 'wants_flexibility' }
  let(:wants_security_text) { 'wants_security' }
  let(:wants_lump_sum_text) { 'wants_lump_sum' }
  let(:poor_health_text) { 'poor_health' }

  def only_includes_circumstance(circumstance)
    circumstances = %i(continue_working unsure leave_inheritance
                       wants_flexibility wants_security
                       wants_lump_sum poor_health)

    unless circumstance.empty?
      expect(subject).to include(send("#{circumstance}_text"))
    end

    (circumstances - [circumstance]).each do |non_applicable_circumstance|
      expect(subject).to_not include(send("#{non_applicable_circumstance}_text"))
    end
  end

  def excludes_all_circumstances
    only_includes_circumstance('')
  end

  let(:customer_name) { "#{title} #{first_name} #{last_name}" }

  describe '#html' do
    subject { output_document.html }

    it { is_expected.to include(customer_name) }

    context 'when ineligible for guidance' do
      before do
        allow(appointment_summary).to receive(:eligible_for_guidance?).and_return(false)
      end

      it { is_expected.to include(ineligible_text) }
      it { is_expected.to_not include(generic_guidance_text) }
      it { excludes_all_circumstances }
    end

    context 'when eligible for guidance' do
      before do
        allow(appointment_summary).to receive(:eligible_for_guidance?).and_return(true)
      end

      context 'with one pension pot value' do
        let(:value_of_pension_pots) { 35_000 }
        let(:upper_value_of_pension_pots) { nil }

        it { is_expected.to include('£35,000') }
      end

      context 'with two pension pot values' do
        let(:value_of_pension_pots) { 35_000 }
        let(:upper_value_of_pension_pots) { 55_000 }

        it { is_expected.to include('£35,000 to £55,000') }
      end

      context 'with no pension pot values' do
        let(:value_of_pension_pots) { nil }
        let(:upper_value_of_pension_pots) { nil }

        it { is_expected.to include('No value given') }
      end

      context 'and generic guidance was given' do
        it { is_expected.to include(generic_guidance_text) }
        it { is_expected.to_not include(ineligible_text) }
        it { excludes_all_circumstances }
      end

      context 'and custom guidance was given' do
        %i(continue_working unsure leave_inheritance wants_flexibility wants_security
           wants_lump_sum poor_health).each do |circumstance|
          context "for '#{circumstance}'" do
            before do
              allow(appointment_summary).to receive("#{circumstance}?".to_sym).and_return(true)
            end

            it { is_expected.to_not include(generic_guidance_text) }
            it { is_expected.to_not include(ineligible_text) }
            it { only_includes_circumstance(circumstance) }
          end
        end
      end
    end
  end

  describe '#pdf' do
    subject { PDF::Inspector::Text.analyze(output_document.pdf).strings.join }

    it { is_expected.to include(customer_name) }
  end
end
