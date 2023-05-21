require "./spec_helper"

describe StumpyResize do
  canvas = StumpyPNG.read("./spec/test_image.png")

  it "resizes using NearestNeighbor" do
    resized = StumpyResize.resize(canvas, 320, 200, :nearest_neighbor)
    resized.width.should eq 320
    resized.height.should eq 200

    StumpyPNG.write(resized, "./bin/nearest_neighbor_small.png")

    # test we can also upsize
    resized = StumpyResize.resize(resized, 640, 400, :nearest_neighbor)
    StumpyPNG.write(resized, "./bin/nearest_neighbor_medium.png")
  end

  it "resizes using Bilinear" do
    resized = StumpyResize.resize(canvas, 320, 200, :bilinear)
    resized.width.should eq 320
    resized.height.should eq 200

    StumpyPNG.write(resized, "./bin/bilinear_small.png")

    # test we can also upsize
    resized = StumpyResize.resize(resized, 640, 400, :bilinear)
    StumpyPNG.write(resized, "./bin/bilinear_medium.png")
  end

  it "resizes using Bicubic" do
    resized = StumpyResize.resize(canvas, 320, 200, :bicubic)
    resized.width.should eq 320
    resized.height.should eq 200

    StumpyPNG.write(resized, "./bin/bicubic_small.png")

    # test we can also upsize
    resized = StumpyResize.resize(resized, 640, 400, :bicubic)
    StumpyPNG.write(resized, "./bin/bicubic_medium.png")
  end

  it "resizes using Lanczos" do
    resized = StumpyResize.resize(canvas, 320, 200, :lanczos)
    resized.width.should eq 320
    resized.height.should eq 200

    StumpyPNG.write(resized, "./bin/lanczos_small.png")

    # test we can also upsize
    resized = StumpyResize.resize(resized, 640, 400, :lanczos)
    StumpyPNG.write(resized, "./bin/lanczos_medium.png")
  end
end
