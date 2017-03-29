class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  def store_dir
    if Rails.env.test?
      Rails.root.join("tmp/testupload/")
    else
      folder = model.identifier.split(/(?=[A-Z])/).join("/")
      "uploads/img/#{folder}"
    end
  end

  version :thumb do
    process resize_to_limit: [250, 250]
  end
  version :small do
    process resize_to_limit: [960, 999999]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    @name ||= sanitize_filename(original_filename) if original_filename
  end

  def sanitize_filename(filename)
    fn = filename.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m
    fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, '_' }
    return fn.join '.'
  end

end
