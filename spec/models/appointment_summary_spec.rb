# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AppointmentSummary, type: :model do
  subject do
    described_class.new(has_defined_contribution_pension: has_defined_contribution_pension)
  end

  let(:has_defined_contribution_pension) { 'yes' }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to_not validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_inclusion_of(:title).in_array(%w(Mr Mrs Miss Ms Mx Dr Reverend)) }
  it { is_expected.to_not allow_value('Alien').for(:title) }

  it do
    is_expected.to(allow_values('2015-02-10', '12/02/2015')
                     .for(:date_of_appointment)
                     .ignoring_interference_by_writer)
  end

  it do
    is_expected.to_not(allow_values('10/02/2012', Time.zone.tomorrow.to_s)
                         .for(:date_of_appointment)
                         .ignoring_interference_by_writer)
  end

  it { is_expected.to validate_presence_of(:guider_name) }
  it { is_expected.to validate_presence_of(:address_line_1) }
  it { is_expected.to_not validate_presence_of(:address_line_2) }
  it { is_expected.to_not validate_presence_of(:address_line_3) }
  it { is_expected.to validate_presence_of(:town) }
  it { is_expected.to_not validate_presence_of(:county) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_inclusion_of(:country).in_array(Countries.all) }
  it { is_expected.to validate_presence_of(:postcode) }
  it { is_expected.to validate_inclusion_of(:number_of_previous_appointments).in_range(0..3) }

  describe '#country' do
    it "has a default value of #{Countries.uk}" do
      expect(subject.country).to eq(Countries.uk)
    end
  end

  it do
    is_expected
      .to validate_inclusion_of(:has_defined_contribution_pension).in_array(%w(yes no unknown))
  end

  it do
    is_expected
      .to validate_inclusion_of(:format_preference).in_array(%w(standard large_text))
  end

  it 'defaults to a standard format preference' do
    expect(subject.format_preference).to eq('standard')
  end

  it do
    is_expected
      .to validate_inclusion_of(:appointment_type).in_array(%w(standard 50_54))
  end

  it 'defaults to a standard appointment type' do
    expect(subject.appointment_type).to eq('standard')
  end

  context 'when ineligible for guidance' do
    let(:has_defined_contribution_pension) { 'no' }

    it { is_expected.to_not be_eligible_for_guidance }
  end

  context 'when eligible for guidance' do
    let(:has_defined_contribution_pension) { 'yes' }

    it { is_expected.to be_eligible_for_guidance }
  end
end
