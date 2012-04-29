require 'spec_helper'

describe Term do
  let(:term){ FactoryGirl.create(:term) }

  before(:each) do
    UrbanDictionaryScraper.stub(:define => nil)
  end

  describe "#update_definitions!" do
    it "should call the load methods for specific definition services" do
      term.should_receive(:update_dictionary_definitions!)
      term.should_receive(:update_urban_definition!)
      term.update_definitions!
    end

    it "should update the timestamp on success" do
      term.last_successful_update_at.should be_nil
      term.stub(:update_urban_definition! => nil, :update_dictionary_definitions! => nil)
      term.update_definitions!
      term.last_successful_update_at.should_not be_nil
    end
  end

  describe "#update_urban_definitions!" do
    let(:urban_definition){ FactoryGirl.create(:urban_definition) }

    before(:each) do
      @def = {:definition => "pie", :example => "delicious"}
    end

    it "should destroy all definitions first" do
      scope = mock :scope
      term.definitions.should_receive(:urban).and_return(scope)
      scope.should_receive(:destroy_all)
      term.send(:update_urban_definition!)
    end

    it "should return nil if it finds nothing from the service" do
      UrbanDictionaryScraper.should_receive(:define).with(term.value).and_return(nil)
      term.send(:update_urban_definition!).should be_nil
    end

    it "should create a new definition if one is returned from the service" do
      UrbanDictionaryScraper.should_receive(:define).with(term.value).and_return(@def)
      UrbanDefinition.should_receive(:create!).with(:term => term, :body => @def[:definition], :example => @def[:example]).and_return(urban_definition)
      term.send(:update_urban_definition!).should == urban_definition
    end
  end
end
