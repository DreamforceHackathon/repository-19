RSpec.describe Prompt do

  it { is_expected.to belong_to :scenario }
  it { is_expected.to validate_presence_of :scenario }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to have_many :responses }

end
