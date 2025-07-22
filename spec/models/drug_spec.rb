require 'rails_helper'

RSpec.describe Drug, type: :model do
  subject { build(:drug, name: "drug") }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to have_many(:injections).dependent(:destroy) }
end
