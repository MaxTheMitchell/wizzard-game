from PIL import Image
import sys
import json

img = Image.open(sys.argv[1], mode="r")
PIXEL_SIZE = int(sys.argv[2])
img_name = img.filename.split("/")[-1]


def scale_img(img, pixel_size):
    return img.resize((img.width//pixel_size, img.height//pixel_size))


def to_json(img):
    return json.dumps(list(img.getdata()))


def to_json_file(data, name):
    data = {
        "img_path": name,
        "data": data
    }
    with open("./{}.json".format(name.split("/")[-1].split(".")[0]), "w") as f:
        f.write(str(data))


to_json_file(to_json(scale_img(img, PIXEL_SIZE)), img.filename)
