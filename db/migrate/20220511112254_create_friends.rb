class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.integer :sender_id, null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :friends, :default => false
      t.timestamps
    end
  end
end
