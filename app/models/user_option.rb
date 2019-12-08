# == Schema Information
#
# Table name: user_options
#
#  id            :integer          not null, primary key
#  email_privacy :integer          default("0"), not null
#  user_id       :uuid             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_user_options_on_user_id  (user_id)
#

class UserOption < ApplicationRecord
  belongs_to :user, inverse_of: :user_option
  enum email_privacy: { private: 0, public: 1 }, _suffix: true
end
