class Shortlink < ApplicationRecord
  has_many :hits
  validates :url, url: true
end
