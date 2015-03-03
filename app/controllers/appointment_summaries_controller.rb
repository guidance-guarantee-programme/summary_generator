class AppointmentSummariesController < ApplicationController
  def new
    @appointment_summary = AppointmentSummary.new
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
    params.require(:appointment_summary).permit(:name, :date_of_appointment)
  end
end
