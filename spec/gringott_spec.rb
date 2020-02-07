RSpec.describe Gringott do
  it "has a version number" do
    expect(Gringott::VERSION).to eq '0.1.0'
  end

  it "defines CommandError" do
    expect(Gringott::CommandError).to be < StandardError
  end

  it "defines CommandError" do
    expect(Gringott::Error).to be < StandardError
  end
end
