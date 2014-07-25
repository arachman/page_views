describe Api::V1::PageViewsController , :type => :controller do
  before do
    @page_views = [
      PageView.create!(:api_key => 'FILDTEOIK2HBORODV', :ip_address => '192.168.1.1', :page_url => 'www.google.com'),
      PageView.create!(:api_key => '12345', :ip_address => '192.168.1.2', :page_url => 'www.google.com'),
      PageView.create!(:api_key => '12345', :ip_address => '192.168.1.2', :page_url => 'www.yahoo.com'),
      PageView.create!(:api_key => '12345', :ip_address => '192.168.1.3', :page_url => 'www.yahoo.com')
    ]
  end

  describe 'GET /index' do
    it "returns a 200 HTTP status" do
      request.env["HTTP_ACCEPT"] = "application/json"
      get 'index', {:api_key => "12345"}
      response.code.should == "200"
    end
  end

  describe 'GET /index' do
    it "returns a 400 HTTP status" do
      request.env["HTTP_ACCEPT"] = "application/json"
      get 'index', {}
      response.code.should == "400"
    end
  end

  describe 'GET /index' do
    it "returns two page_view data" do
      request.env["HTTP_ACCEPT"] = "application/json"
      get 'index', {:api_key => "12345"}
      JSON.parse(response.body)['response']['page_views'].size.should == 3
    end
  end

  describe 'GET /index' do
    it "returns one page_view data" do
      request.env["HTTP_ACCEPT"] = "application/json"
      get 'index', {:api_key => "12345", :url_filters => ['www.yahoo.com']}
      JSON.parse(response.body)['response']['page_views'].size.should == 2
    end
  end

  describe 'GET /index' do
    it "returns one page_view data" do
      request.env["HTTP_ACCEPT"] = "application/json"
      get 'index', {:api_key => '12345', :ip_filters => ['192.168.1.3'], :url_filters => ['www.yahoo.com']}
      JSON.parse(response.body)['response']['page_views'].size.should == 1
    end
  end

  describe 'POST /create' do
    it "returns a 200 HTTP status" do
      request.env["HTTP_ACCEPT"] = "application/json"
      post 'create', {:api_key => "12345", :ip_address => "192.168.1.3", :page_url => "www.foo.com"}
      response.code.should == "200"
    end
  end

  describe 'POST /create' do
    it "returns a 422 HTTP status" do
      request.env["HTTP_ACCEPT"] = "application/json"
      post 'create', {:api_key => "12345", :ip_address => "192.168.1.3"}
      response.code.should == "422"
    end
  end
end
