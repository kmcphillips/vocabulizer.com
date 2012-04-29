require 'spec_helper'

describe User do
  let(:user){ FactoryGirl.create(:user) }

  describe "#public?" do
    it "should return the oposite of private" do
      user.private = false
      user.public.should be_true
      user.public?.should be_true
    end
  end
end
