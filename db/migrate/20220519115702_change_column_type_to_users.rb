class ChangeColumnTypeToUsers < ActiveRecord::Migration[7.0]
  change_table :users do |t|
    t.change :first_name, :string, null: true
    t.change :last_name, :string, null: true
    t.change :date_of_birth, :date, null: true
    t.change :gender, :string, null: true
  end
end
