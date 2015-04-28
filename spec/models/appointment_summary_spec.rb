require 'rails_helper'

RSpec.describe AppointmentSummary, type: :model do
  subject do
    described_class.new(continue_working: continue_working,
                        has_defined_contribution_pension: has_defined_contribution_pension)
  end

  let(:continue_working) { false }
  let(:has_defined_contribution_pension) { 'yes' }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to_not validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_inclusion_of(:title).in_array(%w(Mr Mrs Miss Ms Mx Dr Reverend)) }
  it { is_expected.to_not allow_value('Alien').for(:title) }

  it { is_expected.to allow_value('2015-02-10').for(:date_of_appointment) }
  it { is_expected.to allow_value('12/02/2015').for(:date_of_appointment) }
  it { is_expected.to_not allow_value('10/02/2012').for(:date_of_appointment) }
  it { is_expected.to_not allow_value(Time.zone.tomorrow.to_s).for(:date_of_appointment) }

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
  it { is_expected.to validate_presence_of(:postcode) }

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

    describe 'continue_working' do
      let(:field) { :continue_working }
      it_should_behave_like 'a boolean field'
    end

    describe 'unsure' do
      let(:field) { :unsure }
      it_should_behave_like 'a boolean field'
    end

    describe 'leave_inheritance' do
      let(:field) { :leave_inheritance }
      it_should_behave_like 'a boolean field'
    end

    describe 'wants_flexibility' do
      let(:field) { :wants_flexibility }
      it_should_behave_like 'a boolean field'
    end

    describe 'wants_security' do
      let(:field) { :wants_security }
      it_should_behave_like 'a boolean field'
    end

    describe 'wants_lump_sum' do
      let(:field) { :wants_lump_sum }
      it_should_behave_like 'a boolean field'
    end

    describe 'poor_health' do
      let(:field) { :poor_health }
      it_should_behave_like 'a boolean field'
    end

    describe 'value_of_pension_pots_is_approximate' do
      let(:field) { :value_of_pension_pots_is_approximate }
      it_should_behave_like 'a boolean field'
    end
  end

  context 'when ineligible for guidance' do
    let(:has_defined_contribution_pension) { 'no' }

    it { is_expected.to_not be_eligible_for_guidance }
    it { is_expected.to_not be_generic_guidance }
    it { is_expected.to_not be_custom_guidance }

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

    context 'and no retirement circumstances given' do
      it { is_expected.to be_eligible_for_guidance }
      it { is_expected.to be_generic_guidance }
      it { is_expected.to_not be_custom_guidance }
    end

    context 'and retirement circumstances given' do
      let(:continue_working) { true }

      it { is_expected.to be_eligible_for_guidance }
      it { is_expected.to_not be_generic_guidance }
      it { is_expected.to be_custom_guidance }
    end
  end
end
