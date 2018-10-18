class Book < ActiveRecord::Base
  validates :title, {presence: true}
  validates :author, {presence: true}
  validates :ISBN, {presence: true,uniqueness: true,format:{with: /\A[0-9]+\z/i}}
  validates :category_name, {presence: true}

  has_many :histories
  has_many :reviews

  CATEGORY_HASH = {
    1001 => "漫画（コミック)",
    1002 => "語学・学習参考書",
    1003 => "絵本・児童書・図鑑",
    1004 => "小説・エッセイ",
    1005 => "パソコン・システ ム開発",
    1006 => "ビジネス・経済・就職",
    1007 => "旅行・留学・アウトドア",
    1008 => "人文・思想・社会",
    1009 => "ホビー・スポーツ・美術",
    1010 => "美容・暮らし・健康・料理",
    1011 => "エンタメ・ゲーム",
    1012 => "科学・技術",
    1013 => "写真集・タレント",
    1015 => "その他",
    1016 => "資格・検定",
    1017 => "ライトノベル",
    1018 => "楽譜",
    1019 => "文庫",
    1020 => "新書",
    1021 => "ボーイズラブ（BL）",
    1022 => "付録付き",
    1023 => "バーゲン本",
    1025 => "コミックセット",
    1026 => "カレンダー・手帳・家計簿",
    1027 => "文具・雑貨",
    1028 => "医学・薬学・看護学・歯科学"
  }

def rental
  return Return.find_by(book_id: self.id)
end
end
