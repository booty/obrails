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

  validates :dob, presence: true
  validates :dob_fuzzed, presence: true
  validates :account_status, presence: true
  validates :gender, presence: true

  validates :nick,
            presence: true,
            length: { in: 5..25 },
            uniqueness: true

  validates :friendly_name,
            length: { in: 2..15 }

  validates :gender_comment,
            length: { in: 2..100 },
            allow_blank: true

  def greeting
    "I'm a regular user."
  end

  def dob=(value)
    self.dob_fuzzed = Date.parse(value) + rand(0..1000).days - 500.days
    super(value)
  end
end
