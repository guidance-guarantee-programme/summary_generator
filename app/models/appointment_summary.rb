class AppointmentSummary
  include ActiveModel::Model

  attr_accessor :title, :first_name, :last_name,
                :date_of_appointment,
                :guider_name, :guider_organisation,
                :address_line_1, :address_line_2, :address_line_3, :county, :town, :postcode,
                :country, :has_defined_contribution_pension

  def initialize(params = {})
    super(params.reverse_merge(country: Countries.uk))
  end

  def date_of_appointment
    Date.parse(@date_of_appointment) rescue @date_of_appointment
  end

  TITLES = %w(Mr Mrs Miss Ms Mx Dr Reverend)

  validates :title, presence: true, inclusion: { in: TITLES, allow_blank: true }
  validates :last_name, presence: true
  validates :date_of_appointment, timeliness: { on_or_before: -> { Time.zone.today },
                                                on_or_after: Date.new(2015),
                                                type: :date }

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
  validates :country, presence: true, inclusion: { in: Countries.all }

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
end
