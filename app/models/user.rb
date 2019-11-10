# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           not null
#  biography              :text             default(""), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :lockable
  has_many :projects, foreign_key: 'owner_id'
  has_many :tracks, foreign_key: 'owner_id'

  has_one_attached :icon

  validates :name, presence: true, format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }, uniqueness: { case_sensitive: true }
  validates :icon, content_type: /\Aimage\/.*\z/
  validates :biography, length: { maximum: 300 }

  audited only: :name, max_audits: 3

  attr_writer :login

  scope :recent, -> { order('updated_at DESC') }

  def login
    @login || self.name || self.email
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def to_param
    name
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(name) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
