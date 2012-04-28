class Definition < ActiveRecord::Base

  self.abstract_class = true
  ## NOTE: This doesn't work. Probably going to refactor it to STI.

end
