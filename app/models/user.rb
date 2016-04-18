class User < ActiveRecord::Base
  validates :email, presence: true,
                    uniqueness: true

  validates :password, presence: true

  has_many :links

  has_secure_password
end
