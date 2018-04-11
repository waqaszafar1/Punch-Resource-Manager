require 'rails_helper'

# Test suite for the client model
RSpec.describe Client, type: :model do
  # Association test
  # ensure a Client record has many projects
  it { should have_many(:projects) }
  # Validation test
  # ensure column name \is present before saving
  it { should validate_presence_of(:name) }
end