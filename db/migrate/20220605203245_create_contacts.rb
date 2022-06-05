class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :description
      t.string :email
      t.string :telephone
      t.string :telephone2
      t.boolean :main
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
