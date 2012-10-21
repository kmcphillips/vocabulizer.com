require 'spec_helper'

describe Term do
  
  describe "#populate_details!" do
    before(:each) do
      UrbanDictionary.stub(:define).and_return(nil)
      Wordnik.word.stub(:get_definitions).and_return([])
      Wordnik.word.stub(:get_top_example).and_return(nil) # Should probably raise
    end

    subject{ FactoryGirl.create(:term) }

    let(:wordnik_definition_result){ {"textProns"=>[],
       "sourceDictionary"=>"ahd-legacy",
       "exampleUses"=>[],
       "relatedWords"=>[],
       "labels"=>[],
       "citations"=>[],
       "word"=>"pie",
       "text"=>"A baked food composed of a pastry shell filled with fruit, meat, cheese, or other ingredients, and usually covered with a pastry crust.",
       "sequence"=>"0",
       "score"=>0.0,
       "partOfSpeech"=>"noun",
       "attributionText"=>"from The American Heritage® Dictionary of the English Language, 4th Edition" }
    }
    let(:wordnik_example_result){{"year"=>2009,
       "provider"=>{"name"=>"spinner", "id"=>712},
       "url"=>"http://www.freerepublic.com/focus/f-bloggers/2301558/posts",
       "word"=>"pie",
       "text"=>"The only way to make sure both the poor and rich have enough, is not to quibble over how to divide the pie, but to * bake more pie*.",
       "title"=>"Latest Articles",
       "documentId"=>19030491,
       "exampleId"=>320101333,
       "rating"=>8572.236}
    }

    it "should populate from UrbanDictionary results" do
      pending
      subject.should_receive(:define).with("pie").and_return()
      subject.populate_details!
    end

    it "should populate from Wordnik word results" do
      pending
      Wordnik.word.should_receive(:get_definitions).with("pie").and_return([wordnik_result])
      subject.populate_details!
      subject.terms.size.should eq(1)
    end

    it "should populate from Wordnik example results" do
      pending
    end
  end


  describe "callback" do
    describe "#set_base_value" do
      subject{ FactoryGirl.create(:term, value: "  'PIE-1234_delish'  !")}

      its(:base_value){ should eq("pie-1234_delish") }
    end
  end
end
