class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: { customer: 'customer', admin: 'admin' }

  validates :email, length: { maximum: 150 }, format: { with: /\A[a-zA-Z0-9. _-]+@[a-zA-Z0-9. -]+\.[a-zA-Z]{2,4}\z/ }
  validates :first_name, length: { minimum:5, maximum: 100 }
  validates :last_name, length: { minimum:5, maximum: 100 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


end