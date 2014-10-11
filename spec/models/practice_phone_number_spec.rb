RSpec.describe PracticePhoneNumber do

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :user_practice_phone_numbers }
  it { is_expected.to have_many :users }

  it "can purchase a phone number" do
    subject = FactoryGirl.build(:practice_phone_number)
    expect(subject.purchase_phone_number!).to eq true
    expect(subject.phone_number).to_not be_blank
  end

  it "purchases a phone number before save" do
    expect(subject).to receive(:purchase_phone_number!)
    subject.run_callbacks(:create)
  end

  it "adds the owner to the users in the setter" do
    user = User.new
    subject.owner = user
    expect(subject.users).to include user
  end

  it { is_expected.to belong_to :owner }
  it { is_expected.to validate_presence_of :owner }

  it "validates the inclusion of its owner in its users" do
    subject = FactoryGirl.build(:practice_phone_number)
    expect(subject).to receive(:user_practice_phone_numbers).and_return([])
    subject.valid?
    expect(subject.errors[:users]).to_not be_empty
  end

end
