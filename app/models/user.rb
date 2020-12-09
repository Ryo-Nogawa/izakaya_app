class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # passwordは英数混合で6文字以上
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}+\z/i }
  with_options presence: true do
    validates :nickname,     length: { minimum: 1, maximum: 40 }
    validates :name,         format: { with: /\A[ぁ-んァ-ン一-龥々]/ }
    validates :name_kana,    format: { with: /\A[ァ-ヶー－]/ }
    validates :age,          numericality: { greater_than_or_equal_to: 20 }, format: { with: /\A[0-9]+\z/ }
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  has_many :reserves
  has_many :visuals
  has_many :blogs
  has_many :blog_comments
  has_many :blog_likes
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages
  has_many :foods
  has_many :food_comments
  has_many :food_likes
  has_many :drinks
  has_many :drink_comments
  has_many :drink_likes

end
