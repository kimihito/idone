# == Schema Information
#
# Table name: login_activities
#
#  id             :bigint           not null, primary key
#  scope          :string
#  strategy       :string
#  identity       :string
#  success        :boolean
#  failure_reason :string
#  user_type      :string
#  user_id        :bigint
#  context        :string
#  ip             :string
#  user_agent     :text
#  referrer       :text
#  city           :string
#  region         :string
#  country        :string
#  created_at     :datetime
#
# Indexes
#
#  index_login_activities_on_identity               (identity)
#  index_login_activities_on_ip                     (ip)
#  index_login_activities_on_user_type_and_user_id  (user_type,user_id)
#

class LoginActivity < ApplicationRecord
  belongs_to :user, polymorphic: true, optional: true
end
