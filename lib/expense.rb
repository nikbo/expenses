class Expense < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :cost, :numericality => { :only_integer => true }
  validates :tag, :presence => true
end