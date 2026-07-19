class CreatePassengerBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :passenger_bookings do |t|
      t.belongs_to :booking, null: false, foreign_key: true
      t.belongs_to :passenger, null: false, foreign_key: true

      t.timestamps
    end
  end
end
