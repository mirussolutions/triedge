# encoding: utf-8

class CourseImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/course/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
 
  version :thumb do
    process :resize_to_fill => [220, 220]
  end

  version :small_thumb, :from_version => :thumb do
    process :resize_to_fill => [100, 100]
  end
 

end
