class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    execute <<~SQL
      CREATE TYPE user_gender AS ENUM ('female', 'male', 'trans_female', 'trans_male', 'nonbinary', 'fuck_off', 'let_me_tell_you');
      CREATE TYPE user_account_status AS ENUM ('active', 'retired', 'banned')
    SQL
    create_table :users do |t|
      t.string :type, required: true, index: true
      t.string :nick, required: true
      t.string :friendlyname
      t.string :password, required: true
      t.date :dob, required: true
      t.date :dob_fuzzed, required: true, index: true
      t.datetime :deleted_at, index: true
      t.string :gender_comment
      t.timestamps
      t.datetime :account_status_updated_at, required: true, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :gender_updated_at, required: true, default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_column :users, :gender, :user_gender, after: :password, index: true
    add_column :users, :account_status, :user_account_status, after: :password, index: true
  end

  def down
    drop_table :users
    execute <<~SQL
      DROP TYPE user_gender;
      DROP TYPE user_account_status;
    SQL
  end
end
