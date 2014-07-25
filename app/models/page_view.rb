class PageView < ActiveRecord::Base
  validates :api_key, :ip_address, :page_url, :presence => true

  scope :by_api_key, lambda { |api_key|
    where(:api_key => api_key)
  }
  scope :by_urls, lambda { |urls|
    urls ||= []
    where(:page_url => urls) unless urls.empty?
  }
  scope :by_ips, lambda { |ips|
    ips ||= []
    where(:ip_address => ips) unless ips.empty?
  }
end
