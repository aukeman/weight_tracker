class CreateWeightMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :weight_measurements do |t|

      t.references :user, null: false, on_delete: :cascade, on_update: :cascade
      t.integer :day, null: false
      t.float :weight, null: false

      t.timestamps
    end

    add_index :weight_measurements, [:user_id, :day], unique: true

  end
end
