module StumpyResize
  # Crop function
  def self.crop(canvas : Canvas, start_x : Int32, start_y : Int32, end_x : Int32, end_y : Int32) : Canvas
    # Verify the boundaries
    raise ArgumentError.new("Invalid boundaries") if start_x < 0 || start_y < 0 || end_x > canvas.width || end_y > canvas.height || start_x > end_x || start_y > end_y

    # Calculate new width and height
    new_width = end_x - start_x
    new_height = end_y - start_y

    # Initialize new Canvas
    new_canvas = Canvas.new(new_width, new_height)

    # Copy pixels to the new Canvas
    new_height.times do |y|
      new_width.times do |x|
        old_index = (start_y + y) * canvas.width + (start_x + x)
        new_index = y * new_width + x

        new_canvas.pixels[new_index] = canvas.pixels[old_index]
      end
    end

    new_canvas
  end
end
