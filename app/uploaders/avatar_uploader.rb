# encoding: utf-8
require 'digest/md5'

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env.test?
      "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/assets/default_avatar.gif"
  end

  # Process files as they are uploaded:
  process :resize_to_fill => [140, 140]
  process :convert => 'jpg'
  process :quality => 85
  
  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  def filename
    
    "#{Digest::MD5.hexdigest(file.read)}.jpg" if original_filename
  end

end
