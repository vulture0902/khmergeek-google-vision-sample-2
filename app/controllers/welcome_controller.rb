class WelcomeController < ApplicationController
  include WelcomeHelper

  def top
  end

  def history
    @posts = Post.all
  end

  def upload
    #you have to configure auth file
    #export GOOGLE_APPLICATION_CREDENTIALS="/your/path/key.json"
    tmp = params[:img_data].split(',')
    image_data = Base64.decode64(tmp[1])
    @text = req_gen(image_data)

    post = Post.new
    post.khmer_text = @text
    post.image = params[:img_data]
    post.save

    respond_to do |format|
      format.js {}
    end
  end

end
