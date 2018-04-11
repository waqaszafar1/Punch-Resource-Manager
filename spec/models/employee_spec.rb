require 'rails_helper'

# Test suite for the employee model
RSpec.describe Employee, type: :model do
  # Association test
  # ensure an Employee has many projects record belongs
  it { should have_many(:projects) }
  # Validation test
  # ensure column name and designation is present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:designation) }
end