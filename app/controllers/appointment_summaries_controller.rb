# frozen_string_literal: true
class AppointmentSummariesController < ApplicationController
  def new
    @appointment_summary = AppointmentSummary.new(date_of_appointment: Time.zone.today)
  end

  def create
    appointment_summary = AppointmentSummary.create!(appointment_summary_params)
    output_document = OutputDocument.new(appointment_summary)

    respond_to do |format|
      format.html { render html: output_document.html.html_safe } # rubocop: disable OutputSafety
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
      .permit(*AppointmentSummary.editable_column_names)
      .merge(user: current_user)
  end
end
