require 'rails_helper'
require 'haml'

describe "user/index.html.haml" do
  it "renders the HTML template" do
    assign(:users, [])

    render

    expect(rendered).to match(/table/)
  end

  it "infers the controller path user" do
    expect(controller.request.path_parameters[:controller]).to eq("user")
    expect(controller.request.path_parameters[:action]).to eq("index")
  end
end
