RSpec.describe Recording do

  it { is_expected.to belong_to :recordable }
  it { is_expected.to validate_presence_of :recordable }

end
