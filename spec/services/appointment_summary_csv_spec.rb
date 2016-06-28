# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AppointmentSummaryCsv do
  let(:appointment) { build_stubbed(:appointment_summary) }
  let(:separator) { ',' }

  subject { described_class.new(appointment).call.lines }

  describe '#csv' do
    it 'generates headings' do
      expect(subject.first.chomp.split(separator)).to match_array(
        %w(
          id
          date_of_appointment
          pension_pot_accuracy
          value_of_pension_pots
          upper_value_of_pension_pots
          guider_name
          reference_number
          address_line_1
          address_line_2
          address_line_3
          town
          county
          postcode
          country
          title
          first_name
          last_name
          format_preference
          appointment_type
          has_defined_contribution_pension
          supplementary_benefits
          supplementary_debt
          supplementary_ill_health
          supplementary_defined_benefit_pensions
          income_in_retirement
          plans_to_continue_working
          plan_is_unsure
          plans_to_leave_inheritance
          plans_for_flexibility
          plans_for_security
          plans_for_lump_sum
          plans_for_poor_health
          organisation
        )
      )
    end

    it 'generates correctly mapped rows' do
      expect(subject.last.chomp.split(separator)).to eq(
        [
          appointment.to_param,
          appointment.date_of_appointment.to_s,
          appointment.pension_pot_accuracy.to_s,
          appointment.value_of_pension_pots.to_s,
          appointment.upper_value_of_pension_pots.to_s,
          appointment.guider_name,
          appointment.reference_number,
          appointment.address_line_1,
          appointment.address_line_2,
          appointment.address_line_3,
          appointment.town,
          appointment.county,
          appointment.postcode,
          appointment.country,
          appointment.title,
          appointment.first_name,
          appointment.last_name,
          appointment.format_preference,
          appointment.appointment_type,
          appointment.has_defined_contribution_pension,
          appointment.supplementary_benefits.to_s,
          appointment.supplementary_debt.to_s,
          appointment.supplementary_ill_health.to_s,
          appointment.supplementary_defined_benefit_pensions.to_s,
          appointment.income_in_retirement,
          appointment.plans_to_continue_working.to_s,
          appointment.plan_is_unsure.to_s,
          appointment.plans_to_leave_inheritance.to_s,
          appointment.plans_for_flexibility.to_s,
          appointment.plans_for_security.to_s,
          appointment.plans_for_lump_sum.to_s,
          appointment.plans_for_poor_health.to_s,
          appointment.user.organisation_slug.upcase
        ]
      )
    end
  end
end
