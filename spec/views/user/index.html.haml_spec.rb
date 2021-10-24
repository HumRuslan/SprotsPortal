require 'rails_helper'
require 'haml'

describe "user/index.html.erb" do
  it "renders the HTML template" do
    render

    expect(rendered).to match "/HTML/"
  end
end
