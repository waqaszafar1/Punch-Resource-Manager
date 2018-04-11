require 'rails_helper'

# Test suite for the Project model
RSpec.describe Project, type: :model do
  # Association test
  # ensure a Project belongs to one client.
  it { should belong_to(:client) }
  # ensure n Project has many employees record.
  it { should have_many(:employees) }
  # Validation test
  # ensure column title is present before saving
  it { should validate_presence_of(:title) }

end