require "stumpy_core"

module StumpyResize
  {% begin %}
    VERSION = {{ `shards version "#{__DIR__}"`.chomp.stringify.downcase }}
  {% end %}

  enum InterpolationMethod
    NearestNeighbor
    Bilinear
    Bicubic
    Lanczos
  end

  alias Canvas = StumpyCore::Canvas
  alias RGBA = StumpyCore::RGBA

  def self.resize(image : Canvas, new_width : Int32, new_height : Int32, method : InterpolationMethod = InterpolationMethod::Lanczos) : Canvas
    new_image = Canvas.new(new_width, new_height)

    case method
    in .nearest_neighbor?
      resize_nearest_neighbor(image, new_image)
    in .bilinear?
      resize_bilinear(image, new_image)
    in .bicubic?
      resize_bicubic(image, new_image)
    in .lanczos?
      resize_lanczos(image, new_image)
    end

    new_image
  end
end

require "./stumpy_resize/*"
