class StyleguideController < ApplicationController
  def index
  end

  def pages_input
    render template: 'styleguide/pages/input'
  end

  def pages_output_elements
    respond_to do |format|
      format.html do
        render template: 'styleguide/pages/output_elements', layout: false
      end
      format.pdf do
        render pdf: 'pensionwise.pdf', disposition: :inline,
               template: 'styleguide/pages/output_elements'
      end
    end
  end

  def pages_output_custom
    render_output_document
  end

  def pages_output_generic
    render_output_document(eligible_for_guidance: true, custom_guidance: false, generic_guidance: true)
  end

  def pages_output_ineligible
    render_output_document(eligible_for_guidance: false, custom_guidance: false)
  end

  private

  AppointmentSummary = Struct.new(
    :eligible_for_guidance?, :date_of_appointment, :guider_name,
    :guider_organisation, :title, :first_name, :last_name,
    :value_of_pension_pots, :upper_value_of_pension_pots, :income_in_retirement,
    :custom_guidance?, :continue_working?, :unsure?, :leave_inheritance?,
    :wants_flexibility?, :wants_security?, :wants_lump_sum?, :poor_health?,
    :generic_guidance?, :address_line_2, :address_line_3, :town, :county,
    :postcode
  )

  def render_output_document(eligible_for_guidance: true, custom_guidance: true, generic_guidance: false)
    appointment_summary = AppointmentSummary.new(
      eligible_for_guidance, Time.zone.today, 'Jimmy', 'Pension Wise', 'Mr', 'Joe',
      'Bloggs', 35_000, nil, 'pension', custom_guidance, custom_guidance, false,
      false, false, false, false, false, generic_guidance, '73c', 'Burmah St',
      'Belfast', 'Antrim', 'BT9 1HA'
    )
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
