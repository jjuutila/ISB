require 'spec_helper'

describe LinkCategory do
  context "validations" do
    it { should belong_to(:section) }
    it { should validate_presence_of(:section) }
  end
end
