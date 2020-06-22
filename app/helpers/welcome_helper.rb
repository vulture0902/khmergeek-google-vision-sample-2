require 'net/http'
require "json"
require 'base64'

module WelcomeHelper

  def req_gen(image_data)

req_data = <<-EOS
{
"requests":[
{
  "image":{
    "content":"#{Base64.strict_encode64(image_data)}"
  },
  "features":[
    {
      "type":"DOCUMENT_TEXT_DETECTION"
    }
  ],
  "imageContext": {
    "languageHints": ["km-t-i0-handwrit"]
  }  
}
]
}
EOS

    pre_url = "https://vision.googleapis.com/v1/images:annotate?key=" + ENV['GOOGLE_VISION_API_KEY']
    uri = URI.parse(pre_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true 
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    req.body = req_data
    res = https.request(req)
    hash = JSON.parse(res.body)
    puts '================================================================'
    puts hash["responses"][0]['textAnnotations'][0]['description']
    puts '================================================================'
    return hash["responses"][0]['textAnnotations'][0]['description']

  end

end
