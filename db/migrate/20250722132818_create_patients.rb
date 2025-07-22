class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :api_key

      t.timestamps
    end
    add_index :patients, :api_key, unique: true
  end
end
