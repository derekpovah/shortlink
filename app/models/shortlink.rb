class Shortlink < ApplicationRecord
  validates :url, url: true
end
