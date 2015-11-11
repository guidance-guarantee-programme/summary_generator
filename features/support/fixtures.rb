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
        guider_organisation: 'cita',
        has_defined_contribution_pension: 'yes',
        supplementary_benefits: false,
        supplementary_debt: false,
        supplementary_ill_health: false,
        supplementary_defined_benefit_pensions: false
      )
    end
  }

  private_constant :FIXTURES
end

World(Fixtures)
