class CreateUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :units do |t|
      t.string :type, null: false
      t.integer :extra_points, null: false, default: 0
      t.references :army, foreign_key: true, null: false

      t.timestamps
    end
  end
end
