if Rails.env.development?

  puts "Destroying all exiting data"
  Definition.destroy_all
  Term.destroy_all
  User.destroy_all

  puts "Creating new user 'test@test.com' with password 'asdfasdf'"
  user = User.new :email => "test@test.com", :password => "asdfasdf", :password_confirmation => "asdfasdf"
  user.name = "Kevin McPhillips"
  user.save!

  puts "Creating term and defintion for 'fremdschamen'"
  term = user.terms.create! :value => "fremdschamen"
  Definition.create! :body => "Shame felt for actions done by someone else", :term => term
  UrbanDefinition.create! :body => "The worst feeling ever.", :term => term, :example => "I can't go through the fremdschamen of another Karaoke night"

  puts "Creating new term and definition for 'Go Pear Shaped'"
  term = user.terms.create! :value => "Go Pear Shaped", :phrase => true
  CustomDefinition.create! :body => "Somehing goes wrong or badly", :term => term, :user => user

  puts "Done"
end
