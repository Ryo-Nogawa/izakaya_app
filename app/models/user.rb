class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  # passwordは英数混合で6文字以上
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}+\z/i }
  with_options presence: true do
    validates :nickname,     length: { minimum: 1, maximum: 40 }
    validates :name,         format: { with: /\A[ぁ-んァ-ン一-龥々]/ }
    validates :name_kana,    format: { with: /\A[ァ-ヶー－]/ }
    validates :age,          numericality: { greater_than_or_equal_to: 20 }, format: { with: /\A[0-9]+\z/ }
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  has_many :books
  has_many :visuals
  has_many :blogs
  has_many :blog_comments, dependent: :destroy
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
  has_many :sns_credentials

  def self.find_for_google_oauth2(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      name: auth.info.name,
      email: auth.info.email
    )
    # userが登録済みであるか判断
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
