RSpec.shared_examples "API authentication required" do
  describe "not passing auth params" do
    it "raises error Seekr::HTTPForbidden" do
      expect { request }.to raise_error(Seekr::HTTPForbidden)
    end
  end
end
