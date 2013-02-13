require 'test_helper'

class TermTest < ActiveSupport::TestCase

  def valid_term
    FactoryGirl.create(:term)
  end

  def valid_term_with_details
    term = FactoryGirl.create(:term)
    term.details << FactoryGirl.create(:term_detail)
    term
  end


  test "#populate_details should just return false if there are already some details" do
    term = valid_term_with_details
    term.expects(:populate_from_wordnik).never
    term.expects(:populate_from_urban_dictionary).never
    assert !term.populate_details
  end

  test "#populate_details should build the details from Wordnik and Urban" do
    term = valid_term
    term.expects(:populate_from_wordnik).once
    term.expects(:populate_from_urban_dictionary).once
    assert term.populate_details
  end


  test "#populate_details! should delete all and call #populate_details" do
    term = valid_term_with_details
    assert term.details.size > 0
    term.expects(:populate_details).once
    term.populate_details!
    assert term.details.size == 0
  end


  test "class #base_value should not change anything if it's already a simple word" do
    assert_equal Term.base_value("cake"), "cake"
  end

  test "class #base_value should scrub and set the base value on create" do
    assert_equal Term.base_value("  TREES..."), "tree"
  end


  test "#set_base_value should set the base value if it is not set" do
    Term.expects(:base_value).with("pie").returns("delicious")
    term = FactoryGirl.create(:term, value: "pie", base_value: nil)
    assert_equal term.base_value, "delicious"
  end

  test "#set_base_value should not change anything if it is already set" do
    term = FactoryGirl.create(:term, value: "pie", base_value: "delicious")
    assert_equal term.base_value, "delicious"
  end

  test "#set_base_value should return true since it is a callback, just to be safe" do
    assert valid_term.send(:set_base_value)
  end


  test "#populate_from_wordnik should test the call to the service" do
    pending "Test the service"
  end


  def mock_urban_result
    stub(entries: [
      stub(definition: "a", example: "example a"),
      stub(definition: "b", example: "example b"),
      stub(definition: "c", example: nil),
      stub(definition: "d", example: nil)
    ])
  end

  test "#populate_from_urban_dictionary should test the call to the service" do
    UrbanDictionary.expects(:define).with("pie").returns(mock_urban_result)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_urban_dictionary)
    assert_equal term.details.size, 3
  end

  test "#populate_from_urban_dictionary should limit to the number passed in" do
    UrbanDictionary.expects(:define).with("pie").returns(mock_urban_result)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_urban_dictionary, 2)
    assert_equal term.details.size, 2
  end

  test "#populate_from_urban_dictionary should pass if no entries are found" do
    UrbanDictionary.expects(:define).with("pie").returns(nil)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_urban_dictionary)
    assert_equal term.details.size, 0
  end

  test "#populate_from_urban_dictionary should pull in the expected fields" do
    UrbanDictionary.expects(:define).with("pie").returns(mock_urban_result)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_urban_dictionary)
    detail = term.details.where(definition: "a").first
    assert_not_nil detail
    assert_equal detail.example, "example a"
    assert_equal detail.source, "Urban Dictionary"
    assert detail.urban
  end

end
