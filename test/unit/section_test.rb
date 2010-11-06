require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "leafs" do
    assert_equal(Section.leafs.count, 1)
  end
end
