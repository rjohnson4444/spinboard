class Link < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true,
                  format: URI::regexp(%w(http https))
end
