module StumpyResize
  # scales the original image so that it covers the desired dimensions while maintaining the original aspect ratio.
  # Then it copies the center part of the resized image onto the new canvas, effectively cropping the image.
  def self.scale_to_cover(canvas : Canvas, desired_width : Int32, desired_height : Int32, resize_method : InterpolationMethod = DEFAULT_INTERPOLATION_METHOD) : Canvas
    return canvas if canvas.width == desired_width && canvas.height == desired_height

    # Calculate the scaling factor for width and height
    scale_width = desired_width / canvas.width
    scale_height = desired_height / canvas.height

    # Decide whether to scale by width or height
    scale = [scale_width, scale_height].max

    # Calculate the new scaled dimensions
    scaled_width = (canvas.width.to_f * scale).round.to_i
    scaled_height = (canvas.height.to_f * scale).round.to_i

    # Resize the original canvas
    resized = resize(canvas, scaled_width, scaled_height)
    return resized if scaled_width == desired_width && scaled_height == desired_height

    # Create the new canvas with the desired dimensions
    new_canvas = Canvas.new(desired_width, desired_height)

    # Calculate the starting points for the crop
    start_x = [0, (scaled_width - desired_width) // 2].max
    start_y = [0, (scaled_height - desired_height) // 2].max

    # Copy pixels from the resized canvas to the new canvas, cropping as required
    desired_height.times do |y|
      desired_width.times do |x|
        new_canvas.pixels[y * desired_width + x] = resized.pixels[(y + start_y) * scaled_width + (x + start_x)]
      end
    end

    new_canvas
  end

  # scales the image to fit the desired view port, adding letterboxing or pillarboxing as required
  def self.scale_to_fit(canvas : Canvas, desired_width : Int32, desired_height : Int32, resize_method : InterpolationMethod = DEFAULT_INTERPOLATION_METHOD) : Canvas
    return canvas if canvas.width == desired_width && canvas.height == desired_height

    # Calculate the scaling factor for width and height
    scale_width = desired_width / canvas.width
    scale_height = desired_height / canvas.height

    # Decide whether to add letterboxing or pillarboxing
    scale = {scale_width, scale_height}.min

    # Calculate the new scaled dimensions
    scaled_width = (canvas.width.to_f * scale).round.to_i
    scaled_height = (canvas.height.to_f * scale).round.to_i

    # Resize the original canvas
    resized = resize(canvas, scaled_width, scaled_height, resize_method)
    return resized if scaled_width == desired_width && scaled_height == desired_height

    # Create the new canvas with the desired dimensions
    new_canvas = Canvas.new(desired_width, desired_height)

    # Calculate the padding for width and height
    pad_width = (desired_width - scaled_width) // 2
    pad_height = (desired_height - scaled_height) // 2

    # Copy pixels from the resized canvas to the new canvas, adding padding as required
    resized.height.times do |y|
      resized.width.times do |x|
        new_canvas.pixels[(y + pad_height) * desired_width + (x + pad_width)] = resized.pixels[y * resized.width + x]
      end
    end

    new_canvas
  end
end
