class CreateVoteSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :vote_sessions do |t|
      t.string :ip_address
      t.timestamps
    end
  end
end
