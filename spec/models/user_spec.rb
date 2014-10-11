RSpec.describe User do

  it { is_expected.to have_attribute :first_name }
  it { is_expected.to have_attribute :last_name }

  it { is_expected.to have_many :user_practice_phone_numbers }
  it { is_expected.to have_many :practice_phone_numbers }

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

    describe "setting" do
      before do
        subject.phone_number = value
      end
      context "with 10 digits" do
        let(:value) { "8885551212" }
        it "prepends +1" do
          expect(subject.phone_number).to eq "+1" + value
        end
      end
      context "with more than 10 digits" do
        let(:value) { "18885551212" }
        it "prepends a +" do
          expect(subject.phone_number).to eq "+" + value
        end
      end
      context "with non digits" do
        let(:value) { "+1-888-555-1212" }
        it "strips non digits" do
          expect(subject.phone_number).to eq "+18885551212"
        end
      end
    end
  end

end
