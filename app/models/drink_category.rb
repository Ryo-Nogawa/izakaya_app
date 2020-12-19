class DrinkCategory < ActiveHash::Base
  self.data = [
    { id: 1,  name: '選択してください' },
    { id: 2,  name: 'ビール' },
    { id: 3,  name: 'ハイボール'},
    { id: 4,  name: 'サワー' },
    { id: 5,  name: 'カクテル' },
    { id: 6,  name: 'ウィスキー' },
    { id: 7,  name: 'ワイン' },
    { id: 8,  name: '梅酒' },
    { id: 9,  name: '焼酎' },
    { id: 10, name: '日本酒' },
    { id: 11, name: 'ノンアルコール' }
  ]
  
  include ActiveHash::Associations
  has_many :drinks
end
