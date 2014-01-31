class Recipe < ActiveRecord::Base
  belongs_to :user
  validates :difficulty, numericality: { :less_than_or_equal_to => 5}
  validates :difficulty, numericality: { :greater_than_or_equal_to => 1}
	validates :name, uniqueness: true
	validates :name, presence: true

end