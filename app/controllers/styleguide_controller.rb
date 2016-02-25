class StyleguideController < ApplicationController
  def index
  end

  def pages_input
    render template: 'styleguide/pages/input'
  end

  def pages_output_base
    render_output_document(eligible_for_guidance: true, appointment_type: 'standard')
  end

  def pages_output_50_54
    render_output_document(eligible_for_guidance: true, appointment_type: '50_54')
  end

  def pages_output_base_large
    render_output_document(eligible_for_guidance: true, format_preference: 'large_text')
  end

  def pages_output_50_54_large
    render_output_document(eligible_for_guidance: true, appointment_type: '50_54', format_preference: 'large_text')
  end

  def pages_output_ineligible
    render_output_document(eligible_for_guidance: false)
  end

  private

  AppointmentSummary = Struct.new(
    :eligible_for_guidance?, :date_of_appointment, :guider_name,
    :guider_organisation, :title, :first_name, :last_name,
    :address_line_1, :address_line_2, :address_line_3, :town, :county, :postcode, :country,
    :supplementary_benefits, :supplementary_debt, :supplementary_ill_health, :supplementary_defined_benefit_pensions,
    :format_preference, :appointment_type
  )

  def render_output_document(eligible_for_guidance: true, format_preference: 'standard', appointment_type: 'standard')
    appointment_summary = AppointmentSummary.new(eligible_for_guidance, Time.zone.today, 'Jimmy', 'Pension Wise',
                                                 'Mr', 'Joe', 'Bloggs',
                                                 '73c', 'Burmah St', '', 'Belfast', 'Antrim', 'BT9 1HA', Countries.uk,
                                                 true, true, true, true, format_preference, appointment_type)
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
