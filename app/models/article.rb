class Article < ApplicationRecord

  belongs_to :user
  validates :title, :body, presence: true

  default_scope { order(created_at: :desc)}


end
