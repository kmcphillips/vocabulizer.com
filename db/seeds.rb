if Rails.env.development?

  puts "Destroying all exiting data"
  CustomDefinition.destroy_all
  Term.destroy_all
  User.destroy_all

  puts "Creating new user 'test@test.com' with password 'asdfasdf'"
  user = User.new :email => "test@test.com", :password => "asdfasdf", :password_confirmation => "asdfasdf"
  user.name = "Kevin McPhillips"
  user.save!

  puts "Creating term and defintion for 'fremdschamen'"
  term = user.terms.create! :value => "fremdschamen"
  #term.defintion << CustomDefinition.new :body => "Shame felt for actions done by someone else"

  puts "Creating new term and definition for 'Go Pear Shaped'"
  term = user.terms.create! :value => "Go Pear Shaped"


  puts "Done"
end
