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


  test "scope #include_urban should return all by default" do
    FactoryGirl.create(:term, urban: true)
    FactoryGirl.create(:term, urban: false)
    assert_equal Term.include_urban.size, 2
  end

  test "scope #include_urban should not return the ones flagged as urban if false passed in" do
    FactoryGirl.create(:term, urban: true)
    FactoryGirl.create(:term, urban: false)
    assert_equal Term.include_urban(false).size, 1
  end


  test "scope #top_first should sort by top" do
    other = FactoryGirl.create(:term, top: false)
    top = FactoryGirl.create(:term, top: true)
    assert_equal Term.all, [other, top]
    assert_equal Term.top_first, [top, other]
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


  test "#set_base_value should not change anything if there is already a base value" do
    term = FactoryGirl.create(:term, base_value: "cake")
    term.send(:set_base_value)
    assert_equal term.base_value, "cake"
  end

  test "#set_base_value should scrub and set the base value on create" do
    term = FactoryGirl.create(:term, base_value: nil, value: "  TREES...")
    term.send(:set_base_value)
    assert_equal term.base_value, "tree"
  end

  test "#set_base_value should return true since it is a callback, just to be safe" do
    assert valid_term.send(:set_base_value)
  end


  test "#populate_from_wordnik should test the call to the service" do
    pending "Test the service"
  end


  test "#populate_from_urban_dictionary should test the call to the service" do
    pending "Test the service"
  end

end
