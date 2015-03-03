require 'rails_helper'

RSpec.describe AppointmentSummary, type: :model do
  subject { described_class.new }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to allow_value('2015-02-10').for(:date_of_appointment) }
  it { is_expected.to allow_value('12/02/2015').for(:date_of_appointment) }
  it { is_expected.to_not allow_value('10/02/2012').for(:date_of_appointment) }
  it { is_expected.to_not allow_value(Date.tomorrow.to_s).for(:date_of_appointment) }

  it { is_expected.to validate_presence_of(:value_of_pension_pots) }
  it { is_expected.to allow_value(2000).for(:value_of_pension_pots) }
end
