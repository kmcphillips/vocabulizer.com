class UrbanDefinition < Definition

  belongs_to :term

  validates :body, :presence => true


end
