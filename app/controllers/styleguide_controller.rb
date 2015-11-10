class StyleguideController < ApplicationController
  def index
  end

  def pages_input
    render template: 'styleguide/pages/input'
  end

  def pages_output_base
    render_output_document(eligible_for_guidance: true)
  end

  def pages_output_ineligible
    render_output_document(eligible_for_guidance: false)
  end

  private

  AppointmentSummary = Struct.new(
    :eligible_for_guidance?, :date_of_appointment, :guider_name,
    :guider_organisation, :title, :first_name, :last_name,
    :address_line_1, :address_line_2, :address_line_3, :town, :county, :postcode, :country
  )

  def render_output_document(eligible_for_guidance: true)
    appointment_summary = AppointmentSummary.new(eligible_for_guidance, Time.zone.today, 'Jimmy', 'Pension Wise',
                                                 'Mr', 'Joe', 'Bloggs',
                                                 '73c', 'Burmah St', '', 'Belfast', 'Antrim', 'BT9 1HA', Countries.uk)
    output_document = OutputDocument.new(appointment_summary)

    if params[:format] == 'pdf'
      send_data output_document.pdf,
                filename: 'pensionwise.pdf', type: 'application/pdf',
                disposition: 'inline'
    else
      render html: output_document.html.html_safe
    end
  end
end
