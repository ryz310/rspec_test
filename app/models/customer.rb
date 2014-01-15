class Customer < ActiveRecord::Base
  validates :family_name, presence: true
end
