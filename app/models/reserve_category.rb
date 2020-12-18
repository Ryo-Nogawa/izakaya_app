class ReserveCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択してください' },
    { id: 2, name: 'お席のみ' },
    { id: 3, name: '飲み放題' },
    { id: 4, name: '食べ飲み放題' }
  ]

  include ActiveHash::Associations
  has_many :books
end
