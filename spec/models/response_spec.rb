RSpec.describe Response do

  it { is_expected.to belong_to :prompt }
  it { is_expected.to validate_presence_of :prompt }

  it { is_expected.to belong_to :incoming_call }
  it { is_expected.to validate_presence_of :incoming_call }

  it { is_expected.to have_one(:recording) }

end
