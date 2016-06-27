# frozen_string_literal: true
module Admin
  class AppointmentSummariesController < ::ApplicationController
    before_action :authenticate_admin!

    def index
      @appointment_form = AppointmentSummaryBrowser.new(form_params)

      respond_to do |format|
        format.html
        format.csv { render csv: AppointmentSummaryCsv.new(@appointment_form.results) }
      end
    end

    private

    def form_params
      {
        page:       params[:page],
        start_date: params.dig(:appointment_summary_browser, :start_date),
        end_date:   params.dig(:appointment_summary_browser, :end_date)
      }
    end

    def authenticate_admin!
      authorise_user!('pensionwise_admin')
    rescue PermissionDeniedException
      redirect_to :root
    end
  end
end
