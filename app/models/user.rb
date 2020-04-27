# frozen_string_literal: true

class User < ApplicationRecord
  enum gender: {
    female: "female",
    male: "male",
    trans_female: "trans_female",
    trans_male: "trans_male",
    nonbinary: "nonbinary",
    fuck_off: "fuck_off",
    let_me_tell_you: "let_me_tell_you",
  }

  enum account_status: {
    active: "active",
    retired: "retired",
    banned: "banned",
  }
end
