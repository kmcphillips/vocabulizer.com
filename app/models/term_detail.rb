class TermDetail < ActiveRecord::Base
  attr_accessible :term, :term_id, :definition, :example, :source, :urban, :top

  scope :include_urban, lambda{|flag=true| flag ? scoped : where(urban: false)}
  scope :top_first, order("top DESC")


end
