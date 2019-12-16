class Tag < ApplicationRecord
  has_many :collection_tags

  scope :shuffle, -> { order('RANDOM()') }
end
