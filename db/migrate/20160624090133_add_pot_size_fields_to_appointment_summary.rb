class AddPotSizeFieldsToAppointmentSummary < ActiveRecord::Migration
  def change
    add_column :appointment_summaries, :value_of_pension_pots, :money, scale: 2
    add_column :appointment_summaries, :upper_value_of_pension_pots, :money,  scale: 2
    add_column :appointment_summaries, :pension_pot_accuracy, :string
    add_column :appointment_summaries, :income_in_retirement, :string
    add_column :appointment_summaries, :plans_to_continue_working, :boolean
    add_column :appointment_summaries, :plan_is_unsure, :boolean
    add_column :appointment_summaries, :plans_to_leave_inheritance, :boolean
    add_column :appointment_summaries, :plans_for_flexibility, :boolean
    add_column :appointment_summaries, :plans_for_security, :boolean
    add_column :appointment_summaries, :plans_for_lump_sum, :boolean
    add_column :appointment_summaries, :plans_for_poor_health, :boolean

    add_column :appointment_summaries, :reference_number, :string
  end
end
