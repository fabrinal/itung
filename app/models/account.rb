class Account < ActiveRecord::Base
  validates :value, numericality: true
end
