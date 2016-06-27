# frozen_string_literal: true
class AppointmentSummary < ActiveRecord::Base
  TITLES = %w(Mr Mrs Miss Ms Mx Dr Reverend).freeze

  belongs_to :user

  validates :title, presence: true, inclusion: { in: TITLES, allow_blank: true }
  validates :last_name, presence: true
  validates :date_of_appointment, timeliness: { on_or_before: -> { Time.zone.today },
                                                on_or_after: Date.new(2015),
                                                type: :date }

  validates :guider_name, presence: true
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

  validates :format_preference, inclusion: { in: %w(standard large_text) }
  validates :appointment_type, inclusion: { in: %w(standard 50_54) }

  def eligible_for_guidance?
    %w(yes unknown).include?(has_defined_contribution_pension)
  end

  def self.editable_column_names
    column_names - %w(id created_at updated_at user_id guider_organisation)
  end
end
