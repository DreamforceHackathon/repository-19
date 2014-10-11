RSpec.describe PracticePhoneNumber do

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :user_practice_phone_numbers }
  it { is_expected.to have_many :users }
  it { is_expected.to have_many :scenarios }
  it { is_expected.to have_many :incoming_calls }

  it "can purchase a phone number" do
    subject = FactoryGirl.build_stubbed(:practice_phone_number)
    expect(subject).to receive(:update).with(phone_number: "+15005550006").and_return(true)
    expect(subject.purchase_phone_number!).to eq true
  end

  it "adds the owner to the users in the setter" do
    user = User.new
    subject.owner = user
    subject.valid?
    expect(subject.users).to include user
  end

  it { is_expected.to belong_to :owner }
  it { is_expected.to validate_presence_of :owner }

  it "validates the inclusion of its owner in its users" do
    subject = FactoryGirl.build(:practice_phone_number)
    allow(subject).to receive(:user_practice_phone_numbers).and_return(UserPracticePhoneNumber.none)
    subject.valid?
    expect(subject.errors[:users]).to_not be_empty
  end

end
