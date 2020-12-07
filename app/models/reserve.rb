class Reserve < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :reserve_category

  with_options presence: true do
    # カテゴリーは1以外
    validates :reserve_category_id, numericality: { other_than: 1 }
    # 予約日は過去と今日の日付を選択できない
    validates :reserve_date, :date_not_before_today
    # 予約の時間は半角数字のみ
    validates :reserve_time, format: { with: /\A[0-9]+\z/ }
    # 予約の人数は半角数字かつ20以下
    validates :number_reserve, numericality: { only_integer: true, greater_than: 2, less_than: 20}, format: { with: /\A[0-9]+\z/ }
  end

  def date_not_before_today
    errors.add(:reserve_date, "は今日以降のものを選択してください") if reserve_date < Data.today 
  end

  belongs_to :user
end
