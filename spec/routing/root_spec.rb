require 'rails_helper'

RSpec.describe "routes for root", type: :routing do
  describe "when root path" do
    it "root route to the user with role user" do
      expect(get("/")).to route_to("home#index")
    end

    it "root route to the user with role admin" do
      expect(get("/account/admin/")).to route_to("account/admin/user#index")
    end
  end
end
