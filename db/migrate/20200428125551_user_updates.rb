class UserUpdates < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :friendlyname, :friendly_name
  end
end
