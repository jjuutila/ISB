require 'spec_helper'

describe Link do
  it { should belong_to(:category) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }
end
