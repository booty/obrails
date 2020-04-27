require "rails_helper"

RSpec.describe "factories and shit" do
  it "has valid factories" do
    FactoryBot.factories.each do |factory|
      model = create(factory.name)
      expect(model.valid?).to eq(true)
    end
  end
end
