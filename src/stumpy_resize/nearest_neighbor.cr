module StumpyResize
  def self.resize_nearest_neighbor(image : Canvas, new_image : Canvas) : Nil
    x_ratio = image.width / new_image.width.to_f
    y_ratio = image.height / new_image.height.to_f

    new_image.height.times do |y|
      new_image.width.times do |x|
        px = (x * x_ratio).to_i
        py = (y * y_ratio).to_i

        new_image.pixels[y * new_image.width + x] = image.pixels[py * image.width + px]
      end
    end
  end
end
