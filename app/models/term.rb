class Term < ActiveRecord::Base
  attr_accessible :value, :base_value, :creator, :creator_id, :urban, :top

  has_many :term_details
  alias_method :details, :term_details

  belongs_to :creator, foreign_key: :creator_id, class_name: "User"

  validates :value, presence: true
  validates :base_value, presence: true

  before_validation :set_base_value, on: :create

  scope :include_urban, lambda{|flag=true| flag ? scoped : where(urban: false)}
  scope :top_first, order("top DESC")


  def populate_details
    if self.details.any?
      false
    else
      populate_from_wordnik
      populate_from_urban_dictionary
      true
    end
  end

  def populate_details!
    self.details.destroy_all  # For now we'll just destroy all, but we probably won't want to do that later.
    populate_details
  end

  protected

  def set_base_value
    self.base_value = self.value.downcase.gsub(/(^[\W\s]+)|([\W\s]+$)/, "").singularize if self.base_value.blank?

    true
  end

  def populate_from_wordnik
    Wordnik.word.get_definitions(self.base_value, limit: 7, useCanonical: 'true').each do |entry|
      if entry["citations"].present? # && entry["sourceDictionary"] == "wiktionary"
        example = entry["citations"].map{|c| c["cite"] }.join(" \n")
      else
        example = nil
      end

      self.details.create! definition: entry["text"], source: "Wordnik / #{entry["attributionText"]}", example: example
    end

    begin
      result = Wordnik.word.get_top_example(self.base_value)
      self.details.create! example: result["text"], source: "Wordnik / #{result["title"]}", top: true
    rescue ClientError => e
      raise e unless e.message == "No top example found" # Handle missing examples, but raise every other error
    end
  end

  def populate_from_urban_dictionary(max_entries=3)
    if(urban_word = UrbanDictionary.define(self.base_value))
      urban_word.entries.each_with_index do |entry, index|
        if index < max_entries
          self.details.create! definition: entry.definition, example: entry.example, source: "Urban Dictionary", urban: true
        end
      end
    end
  end

end
