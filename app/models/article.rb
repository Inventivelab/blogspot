class Article < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, :body, presence: true

  default_scope { order(created_at: :desc)}


end
