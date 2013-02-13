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
    assert_equal "cake", Term.base_value("cake")
  end

  test "class #base_value should scrub and set the base value on create" do
    assert_equal "tree", Term.base_value("  TREES...")
  end


  test "#set_base_value should set the base value if it is not set" do
    Term.expects(:base_value).with("pie").returns("delicious")
    term = FactoryGirl.create(:term, value: "pie", base_value: nil)
    assert_equal "delicious", term.base_value
  end

  test "#set_base_value should not change anything if it is already set" do
    term = FactoryGirl.create(:term, value: "pie", base_value: "delicious")
    assert_equal "delicious", term.base_value
  end

  test "#set_base_value should return true since it is a callback, just to be safe" do
    assert valid_term.send(:set_base_value)
  end


  def mock_wordnik_result
    [
      {
        "citations" => [
            {"cite" => "cite 1a"},
            {"cite" => "cite 1b"}
          ],
        "text" => "text 1",
        "attributionText" => "text 1 attribution"
      },
      {
        "citations" => [
            {"cite" => "cite 2a"},
            {"cite" => "cite 2b"}
          ],
        "text" => "text 2",
        "attributionText" => "text 2 attribution"
      },
    ]
  end

  test "#populate_from_wordnik should test the call to the service" do
    Wordnik.word.expects(:get_top_example).raises(ClientError, "No top example found")
    Wordnik.word.expects(:get_definitions).with("pie", limit: 7, useCanonical: 'true').returns(mock_wordnik_result)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_wordnik)
    assert_equal 2, term.details.size
  end

  test "#populate_from_wordnik should set the expected data" do
    Wordnik.word.expects(:get_top_example).raises(ClientError, "No top example found")
    Wordnik.word.expects(:get_definitions).with("pie", limit: 7, useCanonical: 'true').returns(mock_wordnik_result)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_wordnik)
    detail = term.details.where(definition: "text 1").first
    assert_not_nil detail
    assert_equal "Wordnik / text 1 attribution", detail.source
    assert_equal "cite 1a \ncite 1b", detail.example
  end

  test "#populate_from_wordnik should set the top example if it finds one" do
    Wordnik.word.expects(:get_definitions).with("pie", limit: 7, useCanonical: 'true').returns(mock_wordnik_result)
    Wordnik.word.expects(:get_top_example).returns("text" => "top example", "title" => "top attribution")
    term = FactoryGirl.create(:term)
    term.send(:populate_from_wordnik)
    detail = term.details.where(top: true).first
    assert_not_nil detail
    assert_equal "Wordnik / top attribution", detail.source
    assert_equal "top example", detail.example
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
    assert_equal 3, term.details.size
  end

  test "#populate_from_urban_dictionary should limit to the number passed in" do
    UrbanDictionary.expects(:define).with("pie").returns(mock_urban_result)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_urban_dictionary, 2)
    assert_equal 2, term.details.size
  end

  test "#populate_from_urban_dictionary should pass if no entries are found" do
    UrbanDictionary.expects(:define).with("pie").returns(nil)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_urban_dictionary)
    assert_equal 0, term.details.size
  end

  test "#populate_from_urban_dictionary should pull in the expected fields" do
    UrbanDictionary.expects(:define).with("pie").returns(mock_urban_result)
    term = FactoryGirl.create(:term)
    term.send(:populate_from_urban_dictionary)
    detail = term.details.where(definition: "a").first
    assert_not_nil detail
    assert_equal "example a", detail.example
    assert_equal "Urban Dictionary", detail.source
    assert detail.urban
  end

end
