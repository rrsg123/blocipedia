class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  
  default_scope { order('created_at DESC') }
end