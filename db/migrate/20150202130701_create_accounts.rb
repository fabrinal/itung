class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :account_name
      t.string :account_type
      t.decimal :value
      t.string :description

      t.timestamps null: false
    end
  end
end
