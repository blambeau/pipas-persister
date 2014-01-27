Sequel.migration do
  up do
    create_table(:scheduling) do
      column :scheduling_id,  "varchar(36)", null: false
      column :last_scheduled, "timestamp",   null: false
      column :last_modified,  "timestamp",   null: false
      primary_key [:scheduling_id]
    end
    drop_table(:protocol_timestamps)
  end
end
