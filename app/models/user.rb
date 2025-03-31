class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  has_many :events, foreign_key: :creator_id, dependent: :destroy
  has_many :event_attendances, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :event_attendances, source: :attended_event
end
