class AddIdentityToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :identity, :string
  end
end
