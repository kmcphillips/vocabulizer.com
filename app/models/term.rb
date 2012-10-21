class Term < ActiveRecord::Base
  attr_accessible :value, :base_value, :creator, :creator_id

  has_many :term_details
  alias_method :details, :term_details

  belongs_to :creator, foreign_key: :creator_id, class_name: "User"

  validates :value, presence: true
  validates :base_value, presence: true

  before_validation :set_base_value, on: :create


  def populate_details!
    # For now we'll just destroy all, but we probably won't want to do that later.
    self.details.destroy_all

    Wordnik.word.get_definitions(self.base_value, limit: 6, useCanonical: 'true').each do |entry|
      if entry["citations"].present? # && entry["sourceDictionary"] == "wiktionary"
        example = entry["citations"].map{|c| c["cite"] }.join(" \n")
      else
        example = nil
      end

      self.details.create! definition: entry["text"], source: "Wordnik / #{entry["attributionText"]}", example: example
    end

    begin
      result = Wordnik.word.get_top_example(self.base_value)
      self.details.create! example: result["text"], source: "Wordnik / #{result["title"]}"
    rescue ClientError => e
      raise e unless e.message == "No top example found" # Handle missing examples, but raise every other error
    end

    if(urban_word = UrbanDictionary.define(self.base_value))
      urban_word.entries.each do |entry|
        self.details.create! definition: entry.definition, example: entry.example, source: "Urban Dictionary"
      end
    end

    true
  end


  protected

  def set_base_value
    self.base_value = self.value.downcase.gsub(/(^[\W\s]+)|([\W\s]+$)/, "").singularize if self.base_value.blank?

    true
  end
end
