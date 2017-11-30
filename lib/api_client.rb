require 'net/http'
require "uri"
require 'json'


class ApiClient

  HOST = "http://animal-tracking-app.herokuapp.com:80"

  def auth_request
    uri = URI.parse("http://localhost:8000/")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth("username", "password")
    response = http.request(request)
  end

  def post_example
    uri = URI.parse("http://localhost:8000")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({"q" => "My query", "per_page" => "50"})
    request["Content-Type"] = "application/json"

    respose = http.request(request)
  end

  def get_jobs
    url = "#{HOST}/gearman/jobs"
    uri = URI.parse(url)
  
    # Shortcut
    response = Net::HTTP.get_response(uri)
 
    result = JSON.parse(response.body)
    return result
  end

  def get_metrics
    url = "#{HOST}/metrics"
    uri = URI.parse(url)

    response = Net::HTTP.get_response(uri)

    return JSON.parse(response.body)
  end

  def get_homepage
    uri = URI.parse(HOST)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    return response
  end


end