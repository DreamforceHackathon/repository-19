RSpec.describe UserPracticePhoneNumber do
  describe "user" do
    it { is_expected.to belong_to :user }
    it { is_expected.to validate_presence_of :user }
  end
  describe "practice_phone_number" do
    it { is_expected.to belong_to :practice_phone_number }
    it { is_expected.to validate_presence_of :practice_phone_number }
  end
end
