class Definition < ActiveRecord::Base

  belongs_to :term

  validates :body, :presence => true

  scope :custom, where(:type => "CustomDefinition")
  scope :except_custom, where("`type` != ?", "CustomDefinition")
  scope :urban, where(:type => "UrbanDefinition")
  scope :dictionary, where(:type => nil)

end
