require 'net/http'
require "uri"
require 'json'


class ApiClient

  HOST = "https://animal-tracking-app.herokuapp.com/api"

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


  def base_post(path, data_str)
    uri = URI.parse(HOST+path)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri)
    request.body = data_str
    request["content-type"] = "application/json"
    return Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
      http.request(request)
    end    
  end

  def register_user(value)
    return base_post(
      "/user/register",
      '{
        "id": "' + value + '",
        "username": "' + value + '",
        "firstName": "' + value + '",
        "lastName": "' + value + '",
        "email": "' + value + '",
        "password": "' + value + '",
        "phoneNumber": "' + value + '",
        "organization": "' + value + '",
        "role": "Admin"
      }')
  end

  def login_user(value)
    return base_post(
      '/user/login', 
      '{
        "username": "' + value + '",
        "password": "' + value + '"
      }')
  end

  def create_org(value, token)
    return base_post(
      '/organization/?AuthToken=' + token, 
      '{
        "name": "FineNine",
        "type": "Dog Shelter",
        "address": "' + value + '",
        "member": [
          12113,
          12112,
          12114
        ],
        "capacity": 20,
        "available_space": 10,
        "pets": [
          3,
          2,
          4
        ]
      }'
    )
  end 

end