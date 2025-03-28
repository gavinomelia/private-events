class AddAttendeeToEvent < ActiveRecord::Migration[8.0]
  def change
    create_table :event_attendances do |t|
      t.references :attendee, foreign_key: { to_table: :users }
      t.references :attended_event, foreign_key: { to_table: :events }

      t.timestamps
    end

    add_index :event_attendances, [ :attendee_id, :attended_event_id ], unique: true
  end
end
