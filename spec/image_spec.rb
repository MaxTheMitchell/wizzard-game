require_relative "../ruby/image.rb"

describe "An Image" do
  let(:image) { Image.new(path:"spec/test.png") }

  it "can be drawn" do
    expect(image).to respond_to(:draw)
  end

  it "can load a tile set as multipul of images" do
    imgs = Image.load_tiles("spec/test.png", [100, 100], [20, 20])
    expect(imgs.length).to be > 0
    expect(imgs[0]).to be_instance_of(Image)
  end
end
