require 'test_helper'

class TermDetailTest < ActiveSupport::TestCase


  test "scope #include_urban should return all by default" do
    FactoryGirl.create(:term_detail, urban: true)
    FactoryGirl.create(:term_detail, urban: false)
    assert_equal TermDetail.include_urban.size, 2
  end

  test "scope #include_urban should not return the ones flagged as urban if false passed in" do
    FactoryGirl.create(:term_detail, urban: true)
    FactoryGirl.create(:term_detail, urban: false)
    assert_equal TermDetail.include_urban(false).size, 1
  end


  test "scope #top_first should sort by top" do
    other = FactoryGirl.create(:term_detail, top: false)
    top = FactoryGirl.create(:term_detail, top: true)
    assert_equal TermDetail.all, [other, top]
    assert_equal TermDetail.top_first, [top, other]
  end

end
