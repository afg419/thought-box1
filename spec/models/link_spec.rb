require 'rails_helper'

RSpec.describe Link, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:title)}
    it { is_expected.to validate_presence_of(:url)}
  end

  it "saves valid urls" do
    expect(Link.count).to eq 0
    Link.create(title: "Google", url: "http://www.google.com")
    expect(Link.count).to eq 1
  end

  it "doesn't save invalid urls" do
    expect(Link.count).to eq 0
    Link.create(title: "Google", url: "googlecom")
    expect(Link.count).to eq 0
  end
end
