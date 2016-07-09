require File.join(Dir.pwd, "spec/spec_helper.rb")


describe "API endpoints" do

  it "allow root access" do
    get '/'
    expect(last_response).to be_ok
  end

  ## Create
  context 'creates inventory with title, count and product_id' do
    it "inventory may be created" do
      post '/inventory', :title => 'test title', :count => 25, :product_id => 89
      expect(last_response.status).to eq 200
    end
  end

  ## Read
  context 'find by product_id' do
    let!(:inventory){
      FactoryGirl.create(:inventory)
    }
    it "finds inventory" do
      get "/inventory/#{inventory.product_id}"
      expect(last_response.body).to eq(inventory.to_json)
      expect(last_response.status).to eq 200
    end
  end

  ## Update
  context 'update by product_id' do
    let!(:inventory){
      FactoryGirl.create(:inventory)
    }
    it "updates inventory" do
      update_title_to = Faker::Internet.slug
      put "/inventory/#{inventory.product_id}", title:update_title_to
      response_json = JSON.parse(last_response.body)
      expect(response_json["title"]).to eq(update_title_to)
      expect(last_response.status).to eq 200
    end
  end


  ## Delete
  context 'delete by product_id' do
    let!(:inventory){
      FactoryGirl.create(:inventory)
    }
    it "deletes inventory" do
      delete "/inventory/#{inventory.product_id}"
      response_json = JSON.parse(last_response.body)
      expect(response_json["status"]).to eq("success")
      expect(last_response.status).to eq 200
    end
  end

end
