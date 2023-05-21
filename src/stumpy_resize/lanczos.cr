require "math"

module StumpyResize
  # adjust this up to improve quality
  class_property lanczos_a : Int32 = 2

  def self.resize_lanczos(image : Canvas, new_image : Canvas) : Nil
    x_ratio = image.width.to_f / new_image.width
    y_ratio = image.height.to_f / new_image.height

    new_image.height.times do |y|
      new_image.width.times do |x|
        sum_r, sum_g, sum_b, sum_a, sum_weights = 0.0, 0.0, 0.0, 0.0, 0.0

        (-@@lanczos_a..@@lanczos_a).each do |i|
          source_y = ((y.to_f * y_ratio) + i).clamp(0, image.height - 1).to_i
          y_weight = lanczos_weight(i.to_f / y_ratio)

          (-@@lanczos_a..@@lanczos_a).each do |j|
            source_x = ((x.to_f * x_ratio) + j).clamp(0, image.width - 1).to_i
            x_weight = lanczos_weight(j.to_f / x_ratio)

            weight = y_weight * x_weight

            pixel = image.pixels[source_y * image.width + source_x]
            sum_r += pixel.r.to_f * weight
            sum_g += pixel.g.to_f * weight
            sum_b += pixel.b.to_f * weight
            sum_a += pixel.a.to_f * weight
            sum_weights += weight
          end
        end

        r = (sum_r / sum_weights).clamp(0, UInt16::MAX).to_u16
        g = (sum_g / sum_weights).clamp(0, UInt16::MAX).to_u16
        b = (sum_b / sum_weights).clamp(0, UInt16::MAX).to_u16
        a = (sum_a / sum_weights).clamp(0, UInt16::MAX).to_u16

        new_image.pixels[y * new_image.width + x] = RGBA.new(r, g, b, a)
      end
    end
  end

  private def self.lanczos_weight(x : Float64) : Float64
    return 1.0 if x == 0.0
    return 0.0 if x.abs >= @@lanczos_a.to_f

    x_pi = Math::PI * x
    (Math.sin(x_pi) / x_pi) * (Math.sin(x_pi / @@lanczos_a.to_f) / (x_pi / @@lanczos_a.to_f))
  end
end
