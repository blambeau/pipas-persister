Sequel.migration do
  up do
    create_table(:patients) do
      column :patient_id, "varchar(36)",  null: false
      column :last_name,  "varchar(255)", null: false
      column :first_name, "varchar(255)", null: false
      column :gender,     "varchar(1)",   null: false
      primary_key [:patient_id]
    end
    create_table(:treatment_plans) do
      column :tplan_id, "varchar(36)",  null: false
      column :name,     "varchar(255)", null: false
      column :link,     "text",         null: false
      primary_key [:tplan_id]
    end
    create_table(:rest_steps) do
      column :step_id,       "varchar(36)", null: false
      column :tplan_id,      "varchar(36)", null: false
      column :position,      "integer",     null: false
      column :duration,      "float",       null: false
      primary_key [:step_id]
      index [:tplan_id, :position], unique: true
      foreign_key [:tplan_id], :treatment_plans, :null => false, :key => [:tplan_id], :deferrable=>true
    end
    create_table(:delivery_steps) do
      column :step_id,         "varchar(36)", null: false
      column :tplan_id,        "varchar(36)", null: false
      column :position,        "integer",     null: false
      column :prescribed_dose, "float",       null: false
      column :nurse_load,      "float",       null: false
      column :bed_load,        "float",       null: false
      primary_key [:step_id]
      index [:tplan_id, :position], unique: true
      foreign_key [:tplan_id], :treatment_plans, :null => false, :key => [:tplan_id], :deferrable=>true
    end
    create_table(:treatments) do
      column :treatment_id,   "varchar(36)",  null: false
      column :tplan_id,       "varchar(36)",  null: false
      column :patient_id,     "varchar(36)",  null: false
      column :diagnosis_date,        "date",  null: false
      column :earliest_start_date,   "date",  null: false
      column :latest_start_date,     "date",  null: false
      primary_key [:treatment_id]
      foreign_key [:tplan_id], :treatment_plans, :null => false, :key => [:tplan_id], :deferrable=>true
      foreign_key [:patient_id], :patients, :null => false, :key => [:patient_id], :deferrable=>true
    end
    create_table(:prescriptions) do
      column :prescription_id, "varchar(36)", null: false
      column :treatment_id,    "varchar(36)", null: false
      column :step_id,         "varchar(36)", null: false
      column :prescribed_at,     "timestamp", null: false
      column :dose_reduction,        "float", null: false, default: 0.0
      column :dose_reduction_reason,  "text", null: false, default: ""
      primary_key [:prescription_id]
      foreign_key [:treatment_id], :treatments, :null => false, :key => [:treatment_id], :deferrable=>true
      foreign_key [:step_id], :delivery_steps, :null => false, :key => [:step_id], :deferrable=>true
    end
    create_table(:deliveries) do
      column :delivery_id,  "varchar(36)", null: false
      column :treatment_id, "varchar(36)", null: false
      column :step_id,      "varchar(36)", null: false
      column :delivered_at,   "timestamp", null: false
      column :delivered_dose,     "float", null: false
      primary_key [:delivery_id]
      foreign_key [:treatment_id], :treatments, :null => false, :key => [:treatment_id], :deferrable=>true
      foreign_key [:step_id], :delivery_steps, :null => false, :key => [:step_id], :deferrable=>true
    end
    create_table(:appointments) do
      column :appointment_id, "varchar(36)", null: false
      column :treatment_id,   "varchar(36)", null: false
      column :step_id,        "varchar(36)", null: false
      column :scheduled_at,   "timestamp",   null: false
      column :fixed,          "boolean",     null: false
      primary_key [:appointment_id]
      foreign_key [:treatment_id], :treatments, :null => false, :key => [:treatment_id], :deferrable=>true
      foreign_key [:step_id], :delivery_steps, :null => false, :key => [:step_id], :deferrable=>true
    end
    create_table(:bed_availabilities) do
      column :week_day, "varchar(10)", null: false
      column :quantity, "integer",     null: false
      primary_key [:week_day]
    end
    create_table(:nurse_availabilities) do
      column :week_day, "varchar(10)", null: false
      column :quantity, "integer",     null: false
      primary_key [:week_day]
    end
    create_table(:hours_per_day) do
      column :week_day, "varchar(10)", null: false
      column :quantity, "integer",     null: false
      primary_key [:week_day]
    end
    create_table(:patient_unavailabilities) do
      column :treatment_id,   "varchar(36)", null: false
      column :unavailable_at, "timestamp",   null: false
      column :reason,         "text",        null: false
      primary_key [:treatment_id, :unavailable_at]
      foreign_key [:treatment_id], :treatments, :null => false, :key => [:treatment_id], :deferrable=>true
    end
  end
end