class AppointmentSummariesController < ApplicationController
  def new
    @appointment_summary = AppointmentSummary.new(date_of_appointment: Time.zone.today)
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

  def preview
    @appointment_summary = AppointmentSummary.new(appointment_summary_params)
    if @appointment_summary.valid?
      @output_document = OutputDocument.new(@appointment_summary)
    else
      render :new
    end
  end

  private

  def appointment_summary_params
    params
      .require(:appointment_summary)
      .permit(:title, :first_name, :last_name,
              :date_of_appointment,
              :guider_name, :guider_organisation,
              :address_line_1, :address_line_2, :address_line_3, :county, :town, :postcode, :country,
              :has_defined_contribution_pension,
              :supplementary_benefits, :supplementary_debt,
              :supplementary_ill_health, :supplementary_defined_benefit_pensions, :format_preference,
              :appointment_type)
  end
end
