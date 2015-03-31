class CreateSinglegames < ActiveRecord::Migration
  def change
    create_table :singlegames do |t|
      t.string :status
      t.integer :turn
      t.string :winner

      t.timestamps
    end
  end
end
