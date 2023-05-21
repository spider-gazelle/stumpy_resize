module StumpyResize
  def self.blur(image : Canvas, radius : Int32) : Canvas
    raise ArgumentError.new("Radius must be greater than or equal to 1") if radius < 1

    kernel = gaussian_create_kernel(radius)
    intermediate = gaussian_convolve_horizontal(image, kernel)
    gaussian_convolve_vertical(intermediate, kernel)
  end

  private def self.gaussian_create_kernel(radius : Int32) : Array(Float64)
    sigma = radius / 3.0
    size = 2 * radius + 1
    kernel = Array.new(size, 0.0)
    factor = 1 / (Math.sqrt(2 * Math::PI) * sigma)
    sum = 0.0

    size.times do |i|
      x = i - radius
      kernel[i] = factor * Math.exp(-(x ** 2) / (2 * sigma ** 2))
      sum += kernel[i]
    end

    # Normalize the kernel
    kernel.map! { |value| value / sum }

    kernel
  end

  private def self.gaussian_convolve_horizontal(image : Canvas, kernel : Array(Float64)) : Canvas
    radius = kernel.size // 2
    result = Canvas.new(image.width, image.height)

    image.height.times do |y|
      image.width.times do |x|
        r = g = b = a = 0.0
        kernel.each_with_index do |weight, i|
          xi = (x - radius + i).clamp(0, image.width - 1)
          pixel = image.pixels[y * image.width + xi]
          r += pixel.r.to_f * weight
          g += pixel.g.to_f * weight
          b += pixel.b.to_f * weight
          a += pixel.a.to_f * weight
        end
        result.pixels[y * image.width + x] = RGBA.new(r.to_u16, g.to_u16, b.to_u16, a.to_u16)
      end
    end

    result
  end

  private def self.gaussian_convolve_vertical(image : Canvas, kernel : Array(Float64)) : Canvas
    radius = kernel.size // 2
    result = Canvas.new(image.width, image.height)

    image.height.times do |y|
      image.width.times do |x|
        r = g = b = a = 0.0
        kernel.each_with_index do |weight, i|
          yi = (y - radius + i).clamp(0, image.height - 1)
          pixel = image.pixels[yi * image.width + x]
          r += pixel.r.to_f * weight
          g += pixel.g.to_f * weight
          b += pixel.b.to_f * weight
          a += pixel.a.to_f * weight
        end
        result.pixels[y * image.width + x] = RGBA.new(r.to_u16, g.to_u16, b.to_u16, a.to_u16)
      end
    end

    result
  end
end
