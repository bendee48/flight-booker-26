class CreateFlights < ActiveRecord::Migration[8.1]
  def change
    create_table :flights do |t|
      t.datetime :start
      t.integer :duration_mins

      t.references :arrival_airport, null: false, foreign_key: { to_table: :airports }
      t.references :departure_airport, null: false, foreign_key: { to_table: :airports }
      t.timestamps
    end
  end
end
