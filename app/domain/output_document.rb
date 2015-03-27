class OutputDocument
  include ActionView::Helpers::NumberHelper

  attr_accessor :appointment_summary

  def initialize(appointment_summary)
    @appointment_summary = appointment_summary
  end

  def attendee_name
    "#{appointment_summary.title} #{appointment_summary.first_name} #{appointment_summary.last_name}".squish
  end

  def appointment_date
    appointment_summary.date_of_appointment.to_s(:long)
  end

  def guider_organisation
    case appointment_summary.guider_organisation
    when 'cita' then 'Citizens Advice'
    when 'nicab' then 'Citizens Advice Bureau Northern Ireland'
    else 'Pension Wise'
    end
  end

  def value_of_pension_pots
    return 'No value given' if appointment_summary.value_of_pension_pots.blank?

    pension_pot = number_to_currency(appointment_summary.value_of_pension_pots, precision: 0)

    if appointment_summary.upper_value_of_pension_pots.blank?
      pension_pot
    else
      pension_pot + ' to ' + \
        number_to_currency(appointment_summary.upper_value_of_pension_pots, precision: 0)
    end
  end

  def variant
    if appointment_summary.eligible_for_guidance?
      if appointment_summary.custom_guidance?
        'tailored'
      else
        'generic'
      end
    else
      'other'
    end
  end

  def html
    ERB.new(template).result(binding)
  end

  def pdf
    Princely.new.pdf_from_string(html)
  end

  private

  def template
    File.read(
      File.join(Rails.root, 'app', 'templates', 'output_document.html.erb'))
  end
end
