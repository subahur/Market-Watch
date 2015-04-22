class Rule < ActiveRecord::Base
	belongs_to :stock
	belongs_to :user
    has_many :notifications
	accepts_nested_attributes_for :stock


	validates :user, presence: true, length: { minimum: 1 }
	/validates :target_price , presence: true, numericality: true/

	attr_accessor :stock_symbol

	def checkTrigger
	end
end
