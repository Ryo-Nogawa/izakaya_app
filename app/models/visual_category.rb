class VisualCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: "選択してください" },
    { id: 2, name: "外観" },
    { id: 3, name: "内装"}
  ]

  include ActiveHash::Associations
  has_many :visuals
end
