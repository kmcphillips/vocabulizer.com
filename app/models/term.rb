class Term < ActiveRecord::Base

  has_and_belongs_to_many :users, :uniq => true

  has_many :definitions
  


  def update_definitions!
    update_dictionary_definitions!
    update_urban_definition!

    update_attribute(:last_successful_update_at, Time.now)
  end

  protected

  def update_dictionary_definitions!
    definitions.dictionary.destroy_all

    # Wordnik.word.get_definitions(self.value, :use_canonical => true).each do |definition|

    # end
  end

  def update_urban_definition!
    definitions.urban.destroy_all

    if definition = UrbanDictionaryScraper.define(self.value)
      UrbanDefinition.create! :term => self, :body => definition[:definition], :example => definition[:example]
    end
  end

end
