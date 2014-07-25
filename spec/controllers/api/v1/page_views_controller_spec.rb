require 'spec_helper'
describe Api::V1::PageViewsController do
  before do
    @page_views = [
      PageView.create!(:api_key => 'FILDTEOIK2HBORODV', :ip_address => '192.168.1.1', :page_url => 'www.google.com'),
      PageView.create!(:api_key => '12345', :ip_address => '192.168.1.2', :page_url => 'www.google.com')
    ]
  end

  context 'foo' do
    subject do
      get '/api/v1/page_views?api_key=12345&ip_filters[]=192.158.1.1&url_filters[]=www.google.com'
      JSON.parse(response.body)
    end

    it 'should return a list of page views' do
      should == {

      }
    end
  end
  #describe "GET #show" do
  #  before do
  #    get :show, :api_key 
  #  end
  #end
end
