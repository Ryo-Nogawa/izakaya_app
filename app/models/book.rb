class Book < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :reserve_category

  # 予約日は過去と今日の日付を選択できない
  validate :date_not_before_today
  with_options presence: true do
    # カテゴリーは1以外
    validates :reserve_category_id, numericality: {other_than: 1}
    # 予約の時間は必須
    validates :reserve_time
    # 予約の人数は半角数字かつ20以下
    validates :number_reserve, numericality: {only_integer: true, greater_than: 1, less_than: 20}, format: {with: /\A[0-9]+\z/}
  end

  def date_not_before_today
    errors.add(:reserve_date, "は今日以降の日付を選択してください") if reserve_date < Date.today
  end

  belongs_to :user
end
