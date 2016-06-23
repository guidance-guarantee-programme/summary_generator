class CreateAppointmentSummaries < ActiveRecord::Migration
  def change
    create_table 'appointment_summaries', force: :cascade do |t|
      t.string   'address_line_1', default: '', null: false
      t.string   'address_line_2', default: '', null: false
      t.string   'address_line_3', default: '', null: false
      t.string   'town', default: '', null: false
      t.string   'county', default: '', null: false
      t.string   'postcode', default: '', null: false
      t.string   'title', default: '', null: false
      t.string   'first_name', default: '', null: false
      t.string   'last_name', default: '', null: false
      t.string   'country', default: 'United Kingdom', null: false
      t.date     'date_of_appointment', null: false
      t.string   'appointment_type', default: 'standard', null: false
      t.string   'guider_name', default: '', null: false
      t.string   'guider_organisation', default: '', null: false
      t.string   'has_defined_contribution_pension', default: '', null: false
      t.boolean  'supplementary_benefits', default: false
      t.boolean  'supplementary_debt', default: false
      t.boolean  'supplementary_ill_health', default: false
      t.boolean  'supplementary_defined_benefit_pensions', default: false
      t.string   'format_preference', default: 'standard', null: false
      t.integer  'user_id', default: '', null: false

      t.timestamps null: false
    end

    add_index 'appointment_summaries', ['user_id']
  end
end
