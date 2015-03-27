class CreateMultigames < ActiveRecord::Migration
  def change
    create_table :multigames do |t|
      t.string :status
      t.integer :turn
      t.string :player1
      t.string :player2
      t.integer :player1_id
      t.integer :player2_id

      t.timestamps
    end
  end
end
