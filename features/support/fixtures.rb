# frozen_string_literal: false
module Fixtures
  def fixture(name)
    FIXTURES.fetch(name).call
  end

  FIXTURES = {
    populated_appointment_summary: proc do
      AppointmentSummary.new(
        title: 'Mr',
        first_name: 'Joe',
        last_name: 'Bloggs',
        address_line_1: 'HM Treasury',
        address_line_2: '1 Horse Guards Road',
        address_line_3: 'Westminster',
        town: 'London',
        county: 'Greater London',
        country: 'United Kingdom',
        postcode: 'SW1A 2HQ',
        date_of_appointment: '2015-02-05',
        guider_name: 'Penelope',
        has_defined_contribution_pension: 'yes',
        supplementary_benefits: false,
        supplementary_debt: false,
        supplementary_ill_health: false,
        supplementary_defined_benefit_pensions: false,
        supplementary_pension_transfers: false,
        format_preference: 'standard',
        appointment_type: 'standard',
        value_of_pension_pots: '27000',
        upper_value_of_pension_pots: '',
        pension_pot_accuracy: 'exact',
        plans_to_continue_working: false,
        plan_is_unsure: false,
        plans_to_leave_inheritance: true,
        plans_for_flexibility: false,
        plans_for_security: false,
        plans_for_lump_sum: false,
        plans_for_poor_health: false,
        reference_number: 'CITA-1234',
        number_of_previous_appointments: 0,
        count_of_pension_pots: 1,
        retirement_income_other_state_benefits: false,
        retirement_income_employment: false,
        retirement_income_partner: false,
        retirement_income_interest_or_savings: false,
        retirement_income_property: false,
        retirement_income_business: false,
        retirement_income_inheritance: false,
        retirement_income_other_income: false,
        retirement_income_unspecified: false
      )
    end
  }.freeze

  private_constant :FIXTURES
end

World(Fixtures)
