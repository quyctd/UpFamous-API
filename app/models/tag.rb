class Tag < ApplicationRecord
  has_many :collection_tags

  validates :name, presence: true, uniqueness: true

  scope :random, -> { order('RANDOM()') }
end
