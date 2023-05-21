module StumpyResize
  # Cubic Convolution Algorithm
  def self.resize_bicubic(image : Canvas, new_image : Canvas) : Nil
    x_ratio = (image.width - 1).to_f / new_image.width
    y_ratio = (image.height - 1).to_f / new_image.height

    new_image.height.times do |y|
      new_image.width.times do |x|
        x_diff = (x_ratio * x).modulo(1)
        y_diff = (y_ratio * y).modulo(1)
        x_pos = (x_ratio * x).to_i.clamp(0, image.width - 2)
        y_pos = (y_ratio * y).to_i.clamp(0, image.height - 2)

        neighbors = Array.new(4) { Array.new(4) { |i| image.pixels[(y_pos - 1 + i).clamp(0, image.height - 1) * image.width + (x_pos - 1 + i).clamp(0, image.width - 1)] } }

        red = bicubic_interpolation(neighbors.map { |rgba_row| rgba_row.map(&.r) }, x_diff, y_diff)
        green = bicubic_interpolation(neighbors.map { |rgba_row| rgba_row.map(&.g) }, x_diff, y_diff)
        blue = bicubic_interpolation(neighbors.map { |rgba_row| rgba_row.map(&.b) }, x_diff, y_diff)
        alpha = bicubic_interpolation(neighbors.map { |rgba_row| rgba_row.map(&.a) }, x_diff, y_diff)

        new_image.pixels[y * new_image.width + x] = RGBA.new(red, green, blue, alpha)
      end
    end
  end

  private def self.cubic_interpolation(values : Array(UInt16), diff : Float64) : UInt16
    c1 = values[0].to_i
    c2 = values[1].to_i
    c3 = values[2].to_i
    c4 = values[3].to_i

    a0 = c4 - c3 - c1 + c2
    a1 = c1 - c2 - a0
    a2 = c3 - c1
    a3 = c2

    (a0 * diff ** 3 + a1 * diff ** 2 + a2 * diff + a3).clamp(0, UInt16::MAX).to_u16
  end

  private def self.bicubic_interpolation(values : Array(Array(UInt16)), x_diff : Float64, y_diff : Float64) : UInt16
    # Intermediate array to hold results of cubic interpolations in x direction
    intermediate = Array.new(4) { |i| cubic_interpolation(values[i], x_diff) }
    cubic_interpolation(intermediate, y_diff)
  end
end
