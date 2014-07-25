class Api::V1::PageViewsController < ApplicationController
  respond_to :json
  before_filter :check_api_key, :only => :index

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
