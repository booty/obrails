# frozen_string_literal: true

class User < ApplicationRecord
  enum gender: {
    female: 0,
    male: 1,
    trans_female: 2,
    trans_male: 3,
    nonbinary: 4,
    fuck_off: 5,
    let_me_tell_you: 6,
  }

  enum account_status: {
    active: 1,
    retired: 2,
    banned: 3,
  }
end
