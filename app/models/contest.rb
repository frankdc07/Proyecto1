class Contest < ApplicationRecord
  belongs_to :user
  has_many :videos

  has_attached_file :banner, styles: { medium_nr: "250x150!" }

  validates_attachment_content_type :banner, content_type: /\Aimage/

  validates_attachment_presence :banner

end
