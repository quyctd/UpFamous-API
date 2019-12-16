class Tag < ApplicationRecord
  has_many :collection_tags

  scope :random, -> { order('RANDOM()') }
end
