class AppointmentSummariesController < ApplicationController
  def new
    @appointment_summary = AppointmentSummary.new(date_of_appointment: DateTime.now)
  end

  def create
    appointment_summary = AppointmentSummary.new(appointment_summary_params)
    output_document = OutputDocument.new(appointment_summary)

    respond_to do |format|
      format.html { render html: output_document.html.html_safe }
      format.pdf do
        send_data output_document.pdf,
                  filename: 'pension_wise.pdf', type: 'application/pdf',
                  disposition: :inline
      end
    end
  end

  private

  def appointment_summary_params
    params
      .require(:appointment_summary)
      .permit(:title, :first_name, :last_name,
              :date_of_appointment,
              :value_of_pension_pots, :income_in_retirement,
              :upper_value_of_pension_pots, :value_of_pension_pots_is_approximate,
              :guider_name, :guider_organisation,
              :address_line_1, :address_line_2, :address_line_3, :county, :town, :postcode,
              :continue_working, :unsure, :leave_inheritance,
              :wants_flexibility, :wants_security,
              :wants_lump_sum, :poor_health,
              :has_defined_contribution_pension)
  end
end
