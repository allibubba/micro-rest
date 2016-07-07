require File.join(Dir.pwd, "spec/spec_helper.rb")

RSpec.describe Micro::Inventory do
  it { is_expected.to have_field(:title) }
  it { is_expected.to have_field(:title).of_type(String) }
  it { is_expected.to be_timestamped_document }
  # it { is_expected.to have_fields(:title, :count, :product_id) }
end
