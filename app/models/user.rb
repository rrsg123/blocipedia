class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:standard, :premium, :admin]

  # Associations
  
  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :shared_wikis, through: :collaborators, source: :wiki
  
  # Validations
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :name, 
    length: {minimum: 2, maximum: 100}, 
    presence: true
  
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false},
    length: { minimum: 3, maximum: 254},
    format: { with: VALID_EMAIL_REGEX }
  
  # Callbacks
  
  before_save { self.email = email.downcase if self.email.present? }
  
  
  # Instance Methods
  
  def collaborator?(wiki)
    self.collaborators.where(wiki: wiki).present?
  end

  def downgrade!
    ActiveRecord::Base.transaction do
      self.update_attribute(:role, :standard)
      self.wikis.where(private: true).all.each do |wiki|
        wiki.update_attribute(:private, false)
      end
    end
  end
  
end