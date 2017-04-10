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
    process resize_to_limit_gif: [250, 250]
  end
  version :small do
    process resize_to_limit_gif: [960, 999999]
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

  def resize_to_limit_gif (width, height)
    image = Magick::Image::read(current_path).first
    if image.format == 'GIF'
      geometry = Magick::Geometry.new(width, height, 0, 0, Magick::GreaterGeometry)
      frames = Magick::ImageList.new(current_path)
      frames = frames.coalesce
      frames.each_with_index do |frame, index|
        frames[index] = frame.change_geometry(geometry) do |new_width, new_height|
          frame.resize(new_width, new_height)
        end
      end
      frames = frames.optimize_layers(Magick::OptimizePlusLayer)
      frames.write(current_path)
    else
      resize_to_limit(width, height)
    end
  end

end
