json.extract! user, :id, :nick, :friendlyname, :password, :dob, :dob_fuzzed, :gender, :gender_comment, :deleted_at, :usertype, :created_at, :updated_at
json.url user_url(user, format: :json)
