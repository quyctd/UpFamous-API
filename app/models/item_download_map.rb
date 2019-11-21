class ItemDownloadMap < ApplicationRecord
  belongs_to :item
  belongs_to :downloader, foreign_key: :user_id, class_name: 'User'
end
