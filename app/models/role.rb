class Role < ApplicationRecord
  RECRUITER = 'recruiter'.freeze
  CANDIDATE = 'candidate'.freeze
  ADMIN = 'admin'.freeze

  TYPES = [CANDIDATE, RECRUITER, ADMIN].freeze

  validates :name, presence: true

  has_many :permissions, dependent: :destroy
  has_many :users, through: :permissions

  validates :name, inclusion: { in: TYPES }
end
