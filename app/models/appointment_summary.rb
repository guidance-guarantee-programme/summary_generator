class AppointmentSummary
  include ActiveModel::Model

  attr_accessor :name, :date_of_appointment

  def date_of_appointment
    Date.parse(@date_of_appointment) rescue @date_of_appointment
  end

  validates :name, presence: true
  validates :date_of_appointment, timeliness: { on_or_before: -> { Date.current },
                                                on_or_after: Date.new(2015),
                                                type: :date }
end
