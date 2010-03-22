require 'rho/rhocontroller'

class PhotoController < Rho::RhoController
  
  def index
     puts "Camera index controller"
     @images = Photo.find(:all)
   end

   def new
     Camera::take_picture(url_for :action => :camera_callback)
     redirect :action => :index
   end

   def choose
     Camera::choose_picture(url_for :action => :camera_callback)
     redirect :action => :index
   end

   def delete
     @image = Photo.find(@params['id'])
     @image.destroy
     redirect :action => :index
   end

   def camera_callback
      if @params['status'] == 'ok'
        #create image record in the DB
        image = Photo.new({'image_uri'=>@params['image_uri']})
        image.save
        puts "new Image object: " + image.inspect
        WebView.navigate "/app/Photo"
      end
   end
end
