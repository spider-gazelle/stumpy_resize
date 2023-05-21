module StumpyResize
  def self.resize_bilinear(image : Canvas, new_image : Canvas) : Nil
    x_ratio = (image.width - 1).to_f / new_image.width
    y_ratio = (image.height - 1).to_f / new_image.height

    new_image.height.times do |y|
      new_image.width.times do |x|
        x_diff, y_diff, x_pos, y_pos = bilinear_factors(x, y, x_ratio, y_ratio)

        a = image.pixels[y_pos * image.width + x_pos]
        b = image.pixels[y_pos * image.width + (x_pos + 1)]
        c = image.pixels[(y_pos + 1) * image.width + x_pos]
        d = image.pixels[(y_pos + 1) * image.width + (x_pos + 1)]

        red = bilinear_interpolation(a.r, b.r, c.r, d.r, x_diff, y_diff)
        green = bilinear_interpolation(a.g, b.g, c.g, d.g, x_diff, y_diff)
        blue = bilinear_interpolation(a.b, b.b, c.b, d.b, x_diff, y_diff)
        alpha = bilinear_interpolation(a.a, b.a, c.a, d.a, x_diff, y_diff)

        new_image.pixels[y * new_image.width + x] = RGBA.new(red, green, blue, alpha)
      end
    end
  end

  private def self.bilinear_factors(x : Int32, y : Int32, x_ratio : Float64, y_ratio : Float64) : Tuple(Float64, Float64, Int32, Int32)
    x_diff = (x_ratio * x).modulo(1)
    y_diff = (y_ratio * y).modulo(1)
    x_pos = (x_ratio * x).to_i
    y_pos = (y_ratio * y).to_i
    {x_diff, y_diff, x_pos, y_pos}
  end

  private def self.bilinear_interpolation(a : UInt16, b : UInt16, c : UInt16, d : UInt16, x : Float64, y : Float64) : UInt16
    ((a * (1 - x) + b * x) * (1 - y) + (c * (1 - x) + d * x) * y).to_u16
  end
end
