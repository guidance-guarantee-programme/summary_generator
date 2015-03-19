class AppointmentSummary
  include ActiveModel::Model

  attr_accessor :title, :first_name, :last_name,
                :date_of_appointment, :reference_number,
                :value_of_pension_pots, :upper_value_of_pension_pots, :income_in_retirement,
                :guider_name, :guider_organisation,
                :continue_working, :unsure, :leave_inheritance,
                :wants_flexibility, :wants_security,
                :wants_lump_sum, :poor_health,
                :has_defined_contribution_pension

  def date_of_appointment
    Date.parse(@date_of_appointment) rescue @date_of_appointment
  end

  def value_of_pension_pots
    Float.parse(@value_of_pension_pots) rescue @value_of_pension_pots
  end

  def upper_value_of_pension_pots
    Float.parse(@upper_value_of_pension_pots) rescue @upper_value_of_pension_pots
  end

  TITLES = [
    'Mr', 'Mrs', 'Miss', 'Ms', 'Mx', 'Dr', 'Professor', 'Admiral', 'Sir', 'Lady', 'Dame',
    'Admiral Sir', 'Air Chief Marshal', 'Air Commodore', 'Air Vice Marshal', 'The Duchess of ',
    'General', 'General Sir', 'Group Captain', 'Lieutenant General', 'The Reverend',
    'Squadron Leader', 'The Viscount', 'The Viscountess', 'Lt Commander', 'Major The Hon',
    'Captain Viscount', 'The Rt Hon', 'Lt', 'Captain The Hon Sir', 'Prince',
    'Captain The Jonkheer', 'Viscount', 'Viscountess', 'The Hon Lady', 'Hon Mrs', 'Hon',
    'Countess', 'Earl', 'Lord', 'Commodore', 'Air Marshal', 'Flight Lieutenant', 'The Lord',
    'The Lady', 'Baron', 'The Baroness', 'Brigadier', 'Captain', 'Commander', 'Count', 'The Hon',
    'The Hon Mrs', 'Colonel', 'Major', 'Major General', 'His Honour Judge', 'Lt Colonel',
    'Rear Admiral', 'Wing Commander', 'Vice Admiral'
  ]

  validates :title, presence: true, inclusion: { in: TITLES }
  validates :last_name, presence: true
  validates :date_of_appointment, timeliness: { on_or_before: -> { Date.current },
                                                on_or_after: Date.new(2015),
                                                type: :date }
  validates :reference_number, numericality: true, presence: true
  validates :value_of_pension_pots, numericality: true, allow_blank: true
  validates :upper_value_of_pension_pots, numericality: true, allow_blank: true
  validates :income_in_retirement, inclusion: { in: %w(pension other) }
  validates :guider_name, presence: true
  validates :guider_organisation, inclusion: { in: %w(tpas cab) }

  validates :has_defined_contribution_pension, inclusion: { in: %w(yes no unknown) }
end
