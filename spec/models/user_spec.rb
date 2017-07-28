require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should allow_value("user@blocipedia.com").for(:email) }
  it { should_not allow_value("userblocipedia").for(:email) }

  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(8) }

  it { should have_many(:wikis) }

  context "authenticating a user" do
    let(:user) { FactoryGirl.create(:user, password: "password123", password_confirmation: "password123") }

    it "will validate a correct password" do
      user.valid_password?("password123").should be_truthy
    end

    it "will not validate an incorrect password" do
      user.valid_password?("bad-password").should be_falsey
    end
  end
end