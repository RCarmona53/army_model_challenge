class CreateArmies < ActiveRecord::Migration[7.1]
  def change
    create_table :armies do |t|
      t.string :civilization, null: false
      t.integer :gold, null: false, default: 1000

      t.timestamps
    end
  end
end
