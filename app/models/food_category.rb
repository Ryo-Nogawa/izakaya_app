class FoodCategory < ActiveHash::Base
  self.data = [
    { id: 1,  name: '選択してください' },
    { id: 2,  name: 'おすすめ' },
    { id: 3,  name: 'とりあえず' },
    { id: 4,  name: 'サラダ' },
    { id: 5,  name: '一品料理' },
    { id: 6,  name: '串' },
    { id: 7,  name: '焼き物' },
    { id: 8,  name: '海鮮' },
    { id: 9,  name: '主食' },
    { id: 10, name: 'デザート' }
  ]

  include ActiveHash::Associations
  has_many :foods
end
