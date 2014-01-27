Sequel.migration do
  up do
    alter_table(:scheduling) do
      rename_column :scheduling_id, :problem_key
    end
  end
end
