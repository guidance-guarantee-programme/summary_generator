class AppointmentSummariesController < ApplicationController
  def new
    @appointment_summary = AppointmentSummary.new
  end

  def create
    @appointment_summary = AppointmentSummary.new(appointment_summary_params)
    render :new
  end

  private

  def appointment_summary_params
    params.require(:appointment_summary).permit(:name)
  end
end
