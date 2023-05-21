require "./spec_helper"

describe StumpyResize do
  canvas = StumpyPNG.read("./spec/test_image.png")

  it "Gaussian burs an image using" do
    blurred = StumpyResize.blur(canvas, 10)
    StumpyPNG.write(blurred, "./bin/gaussian_bur.png")
  end
end
