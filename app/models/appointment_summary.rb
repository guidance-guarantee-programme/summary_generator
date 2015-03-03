class AppointmentSummary
  include ActiveModel::Model

  attr_accessor :name, :date_of_appointment,
                :value_of_pension_pots, :income_in_retirement,
                :guider_name, :guider_organisation

  def date_of_appointment
    Date.parse(@date_of_appointment) rescue @date_of_appointment
  end

  validates :name, presence: true
  validates :date_of_appointment, timeliness: { on_or_before: -> { Date.current },
                                                on_or_after: Date.new(2015),
                                                type: :date }
  validates :value_of_pension_pots, presence: true, numericality: true
  validates :income_in_retirement, inclusion: { in: %w(pension other) }
  validates :guider_name, presence: true
  validates :guider_organisation, inclusion: { in: %w(tpas cab) }
end
