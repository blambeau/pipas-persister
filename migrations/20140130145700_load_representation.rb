Sequel.migration do
  up do
    alter_table(:delivery_steps) do
      set_column_type :nurse_load, "integer"
      set_column_type :bed_load, "integer"
    end
    alter_table(:rest_steps) do
      set_column_type :duration, "integer"
    end
    rename_table(:hours_per_day, :minutes_per_day)
  end
end
