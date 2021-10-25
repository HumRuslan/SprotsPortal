require 'rails_helper'

RSpec.describe "routes for root", type: :routing do
  it "root route to the user controller" do
    expect(get("/")).to route_to("user#index")
  end
end
