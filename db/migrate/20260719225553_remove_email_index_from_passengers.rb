class RemoveEmailIndexFromPassengers < ActiveRecord::Migration[8.1]
  def change
    remove_index :passengers, column: :email
  end
end
