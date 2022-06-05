class CreateCustomersOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :customers_operations do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :operation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
