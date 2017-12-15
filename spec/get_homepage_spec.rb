require 'securerandom'
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

  # it "should get 200 when fetching the homepage" do
  #   client = ApiClient.new
  #   body = client.get_homepage
  #   expect(body.code).to eql "200" 
  # end

  it "should get a 200 when register an new account" do
    client = ApiClient.new
    body = client.register_user(SecureRandom.hex(10))
    # puts "[Info] " + body.body
    expect(body.code).to eql "200"
  end

  it "should get a 400 when register an existing account" do
    client = ApiClient.new
    body = client.register_user('string')
    # puts "[Info] " + body.body
    expect(body.code).to eql "400"
  end

  it "should get a 200 when login an registered account" do
    client = ApiClient.new
    body = client.login_user('string')
    # puts "[Info] " + body.body
    expect(body.code).to eql "200"
  end

  it "should get a 400 when login an random account" do
    client = ApiClient.new
    body = client.login_user(SecureRandom.hex(10))
    # puts "[Info] " + body.body
    expect(body.code).to eql "400"
  end

  it "should get a 201 when creating an organization" do
    client = ApiClient.new
    body = client.login_user('sampleAdmin')
    puts "[Info] " + body.body
    body = client.create_org('127791 1st ave', body.body['token'])
    puts "[Info] " + body.body
    expect(body.code).to eql "201"
  end  
end

