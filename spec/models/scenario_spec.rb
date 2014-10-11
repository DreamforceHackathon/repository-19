RSpec.describe Scenario do

  it { is_expected.to belong_to :practice_phone_number }
  it { is_expected.to validate_presence_of :practice_phone_number }
  it { is_expected.to have_attribute :name }
  it { is_expected.to validate_presence_of :name }

end
