Sequel.migration do
  up do
    alter_table(:appointments) do
      add_index [:treatment_id, :step_id], unique: true
    end
    alter_table(:deliveries) do
      add_index [:treatment_id, :step_id], unique: true
    end
    alter_table(:prescriptions) do
      add_index [:treatment_id, :step_id], unique: true
    end
  end
end