require "./spec_helper"

describe StumpyResize do
  it "scales down image to fit desired frame" do
    canvas = StumpyCore::Canvas.new(60, 30, StumpyCore::RGBA.new(0_u16, 0_u16, 0_u16, UInt16::MAX))
    output = StumpyResize.scale_to_fit(canvas, 20, 20)
    StumpyPNG.write(output, "./bin/fit_down_letter.png")

    canvas = StumpyCore::Canvas.new(30, 60, StumpyCore::RGBA.new(0_u16, 0_u16, 0_u16, UInt16::MAX))
    output = StumpyResize.scale_to_fit(canvas, 20, 20)
    StumpyPNG.write(output, "./bin/fit_down_pillar.png")
  end

  it "scales up image to fit desired frame" do
    canvas = StumpyCore::Canvas.new(60, 30, StumpyCore::RGBA.new(0_u16, 0_u16, 0_u16, UInt16::MAX))
    output = StumpyResize.scale_to_fit(canvas, 100, 100)
    StumpyPNG.write(output, "./bin/fit_up_letter.png")

    canvas = StumpyCore::Canvas.new(30, 60, StumpyCore::RGBA.new(0_u16, 0_u16, 0_u16, UInt16::MAX))
    output = StumpyResize.scale_to_fit(canvas, 100, 100)
    StumpyPNG.write(output, "./bin/fit_up_pillar.png")
  end

  it "scales down image to cover desired frame" do
    canvas = StumpyCore::Canvas.new(60, 30, StumpyCore::RGBA.new(0_u16, 0_u16, 0_u16, UInt16::MAX))
    output = StumpyResize.scale_to_cover(canvas, 20, 20)
    StumpyPNG.write(output, "./bin/cover_down.png")
  end

  it "scales up image to cover desired frame" do
    canvas = StumpyCore::Canvas.new(30, 60, StumpyCore::RGBA.new(0_u16, 0_u16, 0_u16, UInt16::MAX))
    output = StumpyResize.scale_to_cover(canvas, 100, 100)
    StumpyPNG.write(output, "./bin/cover_up.png")
  end
end
