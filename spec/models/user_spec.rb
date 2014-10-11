RSpec.describe User do

  it { is_expected.to have_attribute :first_name }
  it { is_expected.to have_attribute :last_name }

  describe "phone_number" do
    it { is_expected.to validate_presence_of :phone_number }
    
    it "is not valid when formatted incorrectly" do
      subject.phone_number = "a b c"
      subject.valid?
      expect(subject.errors[:phone_number]).to_not be_empty
    end

    it "is valid when formatted correctly" do
      subject.phone_number = "8885551212"
      subject.valid?
      expect(subject.errors[:phone_number]).to be_empty
    end
  end

end
