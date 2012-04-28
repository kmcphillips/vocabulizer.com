class Term < ActiveRecord::Base

  belongs_to :user

  has_many :definitions
  
end
