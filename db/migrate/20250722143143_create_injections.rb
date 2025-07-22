class CreateInjections < ActiveRecord::Migration[8.0]
  def change
    create_table :injections do |t|
      t.integer :dose, null: false
      t.string :lot_number, limit: 6, null: false
      t.references :patient, null: false, foreign_key: true
      t.references :drug, null: false, foreign_key: true

      t.timestamps
    end
  end
end
