class AppointmentSummariesController < ApplicationController
  def new
    @appointment_summary = AppointmentSummary.new
  end

  def create
    @appointment_summary = AppointmentSummary.new(appointment_summary_params)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'pension_wise', encoding: 'utf-8'
      end
    end
  end

  private

  def appointment_summary_params
    params.require(:appointment_summary).permit(:name)
  end
end
