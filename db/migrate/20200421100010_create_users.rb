class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :nick
      t.string :friendlyname
      t.string :password
      t.date :dob
      t.date :dob_fuzzed
      t.string :gender
      t.string :gender_comment
      t.datetime :deleted_at
      t.string :usertype

      t.timestamps
    end
  end
end
