class CreateSinglegames < ActiveRecord::Migration
  def change
    create_table :singlegames do |t|
      t.string :status
      t.integer :turn

      t.timestamps
    end
  end
end
