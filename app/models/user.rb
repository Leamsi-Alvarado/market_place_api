class User < ApplicationRecord
  #Validations
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true
  #Password hash
  has_secure_password

  #Relations with other models
  has_many :products, dependent: :destroy
end
