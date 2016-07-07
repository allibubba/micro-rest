require File.expand_path '../spec_helper.rb', __FILE__

describe "API endpoints" do
  it "allow root access" do
    get '/'
    expect(last_response).to be_ok
  end
end
