class CreateBattles < ActiveRecord::Migration[7.1]
  def change
    create_table :battles do |t|
      t.references :attacker, null: false, foreign_key: true
      t.references :defender, null: false, foreign_key: true
      t.string :result
      t.integer :attacker_points
      t.integer :defender_points
      t.datetime :occurred_at

      t.timestamps
    end
  end
end
