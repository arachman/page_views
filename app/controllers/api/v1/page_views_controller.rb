class Api::V1::PageViewsController < ApplicationController
  respond_to :json
  before_filter :check_api_key, :only => :index

  ##
  # Accepts and stores page view data
  #
  # POST /api/v1/page_views
  #
  # params:
  #   api_key     - required
  #   page_url    - required
  #   ip_address  - required
  #
  # = Examples
  #
  # curl -X POST -H "Content-Type: application/json" \
  # "http://tranquil-mesa-2301.herokuapp.com/api/v1/page_views" -d ' \
  # {"api_key" : "12345", "ip_address" : "192.158.1.3", "page_url" : "www.google.com"}'
  #
  def create
    @page_view = PageView.new(
      :api_key    => params[:api_key],
      :ip_address => params[:ip_address],
      :page_url   => params[:page_url]
    )

    if @page_view.save
      render :json => @page_view, :status => :ok
    else
      render :json => {
        :response => {
          :errors => @page_view.errors.full_messages
        }
      }, :status => 422
    end
  end

  ##
  # Returns a list of page view data for a given api key. Accepts
  # optional parameters to filter the results by urls and/or ip addresses
  #
  # GET /api/v1/page_views
  #
  # params:
  #   api_key     - required
  #   url_filters - optional array of urls
  #   ip_filters  - optional array of ip addresses
  #
  # = Examples
  #
  # curl -X GET -H "Content-Type: application/json" \
  # "http://tranquil-mesa-2301.herokuapp.com/api/v1/page_views" -d ' \
  # {"api_key" : "12345"}'
  #
  # curl -X GET -H "Content-Type: application/json" \
  # "http://tranquil-mesa-2301.herokuapp.com/api/v1/page_views" -d ' \
  # {"api_key" : "12345", "url_filters" : ["www.yahoo.com"]}'
  #
  def index
    respond_to do |format|
      format.json do
        render :json => {
          :response => {
            :page_views => PageView.by_api_key(params[:api_key]).
            by_urls(params[:url_filters]).
            by_ips(params[:ip_filters])
          }
        }, :status => 200
      end
    end
  end

  protected

  def check_api_key
    if(params[:api_key].nil?)
      render :json => {
        :response => {
          :errors => ['Missing required parameter: api_key']
        }
      }, :status => 400
    end
  end
end
