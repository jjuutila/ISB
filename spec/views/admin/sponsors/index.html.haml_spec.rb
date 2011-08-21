require 'spec_helper'

describe "admin/sponsors/index.html.haml" do
  before(:each) do
    assign(:sponsors, [
      stub_model(Sponsor,
        :name => "Name",
        :url => "Url",
        :position => 1
      ),
      stub_model(Sponsor,
        :name => "Name",
        :url => "Url",
        :position => 1
      )
    ])
  end

  it "renders correctly" do
    render
  end
end
