class CreateDrugs < ActiveRecord::Migration[8.0]
  def change
    create_table :drugs do |t|
      t.string :name

      t.timestamps
    end
    add_index :drugs, :name, unique: true
  end
end
