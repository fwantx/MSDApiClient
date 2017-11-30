require 'spec_helper'
 
describe ApiClient do

  # it "should get a 301 when fetching the homepage" do 
  #   client = ApiClient.new
  #   body = client.get_jobs
  #   puts body
  #   expect(body["reverse_string"]).to eql 3
  # end 

  # it "should get some metrics" do 
  #   client = ApiClient.new
  #   metrics = client.get_metrics
  #   puts metrics
  #   expect(metrics["version"]).to eql "3.0.0"
  #   expect(metrics["gauges"]["queues.pending-jobs"]["value"]).to eql 1
  # end

  it "should get 200 when fetching the homepage" do
    client = ApiClient.new
    body = client.get_homepage
    expect(body.code).to eql "200" 
  end
end