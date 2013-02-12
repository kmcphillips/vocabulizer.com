require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def valid_user
    FactoryGirl.create(:user)
  end

  test "#password_required? should require a password when it is not persisted" do
    assert User.new(password: "pie", password_confirmation: "pie").send(:password_required?)
  end

  test "#password_required? should require a password when it is persisted and the password is not nil" do
    user = valid_user
    user.password = "pie"
    assert user.send(:password_required?)
  end

  test "#password_required? should require a password when it is persisted and the password_confirmation is not nil" do
    user = valid_user
    user.password_confirmation = "pie"
    assert user.send(:password_required?)
  end




end
