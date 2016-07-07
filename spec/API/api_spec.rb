require File.join(Dir.pwd, "spec/spec_helper.rb")

describe "API endpoints" do
  it "allow root access" do
    get '/'
    expect(last_response).to be_ok
  end

  ## Create
  it "inventory may be created" do
    post '/inventory', :title => 'test title', :count => 25, :product_id => 89
    expect(last_response.status).to eq 200
  end

end
