class CreateContestants < ActiveRecord::Migration[8.1]
  def change
    create_table :contestants do |t|
      t.string :name
      t.timestamps
    end
  end
end
