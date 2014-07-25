describe Api::V1::PageViewsController , :type => :controller do
  before do
    @page_views = [
      PageView.create!(:api_key => 'FILDTEOIK2HBORODV', :ip_address => '192.168.1.1', :page_url => 'www.google.com'),
      PageView.create!(:api_key => '12345', :ip_address => '192.168.1.2', :page_url => 'www.google.com')
    ]
  end

  describe 'page_views.json' do
    it "returns a 200 HTTP status" do
      request.env["HTTP_ACCEPT"] = "application/json"
      get 'index', { :api_key => "12345" }.to_json
      expect(response).to be_success
    end
  end

end
