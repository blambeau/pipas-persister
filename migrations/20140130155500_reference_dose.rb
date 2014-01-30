Sequel.migration do
  up do
    alter_table(:delivery_steps) do
      rename_column(:prescribed_dose, :reference_dose)
    end
  end
end
