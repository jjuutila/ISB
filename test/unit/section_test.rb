require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  test "leafs" do
    assert_equal(1, Section.leafs.count)
  end
end
