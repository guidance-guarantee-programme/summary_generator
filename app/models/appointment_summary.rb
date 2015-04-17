class AppointmentSummary
  include ActiveModel::Model

  attr_accessor :title, :first_name, :last_name,
                :date_of_appointment,
                :value_of_pension_pots, :income_in_retirement,
                :upper_value_of_pension_pots, :value_of_pension_pots_is_approximate,
                :guider_name, :guider_organisation,
                :address_line_1, :address_line_2, :address_line_3, :county, :town, :postcode,
                :continue_working, :unsure, :leave_inheritance,
                :wants_flexibility, :wants_security,
                :wants_lump_sum, :poor_health,
                :has_defined_contribution_pension

  %i(continue_working unsure leave_inheritance wants_flexibility wants_security
     wants_lump_sum poor_health value_of_pension_pots_is_approximate).each do |predicate_method|
    define_method("#{predicate_method}=") do |value|
      boolean = [true, 'true', '1', 1].member?(value)
      instance_variable_set("@#{predicate_method}", boolean)
    end

    alias_method(:"#{predicate_method}?", predicate_method)
  end

  def date_of_appointment
    Date.parse(@date_of_appointment) rescue @date_of_appointment
  end

  def value_of_pension_pots
    Float.parse(@value_of_pension_pots) rescue @value_of_pension_pots
  end

  def upper_value_of_pension_pots
    Float.parse(@upper_value_of_pension_pots) rescue @upper_value_of_pension_pots
  end

  TITLES = %w(Mr Mrs Miss Ms Mx Dr)

  validates :title, presence: true, inclusion: { in: TITLES, allow_blank: true }
  validates :last_name, presence: true
  validates :date_of_appointment, timeliness: { on_or_before: -> { Time.zone.today },
                                                on_or_after: Date.new(2015),
                                                type: :date }

  with_options numericality: true, allow_blank: true, if: :eligible_for_guidance? do |eligible|
    eligible.validates :value_of_pension_pots
    eligible.validates :upper_value_of_pension_pots
  end

  validates :income_in_retirement, inclusion: { in: %w(pension other) }, if: :eligible_for_guidance?
  validates :guider_name, presence: true
  validates :guider_organisation,
            presence: true,
            inclusion: {
              in: %w(nicab cita),
              allow_blank: true,
              message: '%{value} is not a valid organisation'
            }

  validates :address_line_1, presence: true
  validates :town, presence: true
  validates :postcode, presence: true

  validates :has_defined_contribution_pension,
            presence: true,
            inclusion: {
              in: %w(yes no unknown),
              allow_blank: true,
              message: '%{value} is not a valid value'
            }

  def eligible_for_guidance?
    %w(yes unknown).include?(has_defined_contribution_pension)
  end

  def generic_guidance?
    eligible_for_guidance? && !retirement_circumstances?
  end

  def custom_guidance?
    eligible_for_guidance? && retirement_circumstances?
  end

  private

  # rubocop:disable CyclomaticComplexity
  def retirement_circumstances?
    continue_working? || unsure? || leave_inheritance? || \
      wants_flexibility? || wants_security? || wants_lump_sum? || \
      poor_health?
  end
  # rubocop:enable CyclomaticComplexity
end
