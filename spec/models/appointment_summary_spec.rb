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

  it { is_expected.to_not validate_presence_of(:value_of_pension_pots) }
  it { is_expected.to validate_numericality_of(:value_of_pension_pots) }
  it { is_expected.to allow_value('').for(:value_of_pension_pots) }

  it { is_expected.to_not validate_presence_of(:upper_value_of_pension_pots) }
  it { is_expected.to validate_numericality_of(:upper_value_of_pension_pots) }
  it { is_expected.to allow_value('').for(:upper_value_of_pension_pots) }

  it { is_expected.to validate_inclusion_of(:income_in_retirement).in_array(%w(pension other)) }

  it { is_expected.to validate_presence_of(:guider_name) }
  it { is_expected.to validate_inclusion_of(:guider_organisation).in_array(%w(cita nicab)) }

  it { is_expected.to validate_presence_of(:address_line_1) }
  it { is_expected.to_not validate_presence_of(:address_line_2) }
  it { is_expected.to_not validate_presence_of(:address_line_3) }
  it { is_expected.to validate_presence_of(:town) }
  it { is_expected.to_not validate_presence_of(:county) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_inclusion_of(:country).in_array(Countries.all) }
  it { is_expected.to validate_presence_of(:postcode) }

  describe '#country' do
    it "has a default value of #{Countries.uk}" do
      expect(subject.country).to eq(Countries.uk)
    end
  end

  it do
    is_expected
      .to validate_inclusion_of(:has_defined_contribution_pension).in_array(%w(yes no unknown))
  end

  describe 'boolean fields' do
    shared_examples 'a boolean field' do
      def set(value)
        subject.public_send(:"#{field}=", value)
      end

      def get
        subject.public_send(field)
      end

      it 'converts "true" to true' do
        set('true')
        expect(get).to be(true)
      end

      it 'converts "1" to true' do
        set('1')
        expect(get).to be(true)
      end

      it 'converts 1 to true' do
        set(1)
        expect(get).to be(true)
      end

      it 'leaves true as true' do
        set(true)
        expect(get).to be(true)
      end

      it 'converts "random" to false' do
        set('random')
        expect(get).to be(false)
      end

      it 'converts "0" to false' do
        set('0')
        expect(get).to be(false)
      end

      it 'converts 0 to false' do
        set(0)
        expect(get).to be(false)
      end
    end

    describe 'value_of_pension_pots_is_approximate' do
      let(:field) { :value_of_pension_pots_is_approximate }
      it_should_behave_like 'a boolean field'
    end
  end

  context 'when ineligible for guidance' do
    let(:has_defined_contribution_pension) { 'no' }

    it { is_expected.to_not be_eligible_for_guidance }

    it { is_expected.to_not validate_presence_of(:value_of_pension_pots) }
    it { is_expected.to_not validate_presence_of(:upper_value_of_pension_pots) }

    it { is_expected.to_not validate_numericality_of(:value_of_pension_pots) }
    it { is_expected.to_not validate_numericality_of(:upper_value_of_pension_pots) }

    it do
      is_expected.to_not validate_inclusion_of(:income_in_retirement).in_array(%w(pension other))
    end
  end

  context 'when eligible for guidance' do
    let(:has_defined_contribution_pension) { 'yes' }

    it { is_expected.to be_eligible_for_guidance }
  end
end
