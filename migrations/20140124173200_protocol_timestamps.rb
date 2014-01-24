Sequel.migration do
  up do
    create_table(:protocol_timestamps) do
      column :key,                "integer",   null: false
      column :scheduled_at,       "timestamp", null: false
      column :accuracy_timestamp, "timestamp", null: false
      primary_key [:key]
    end
  end
end
