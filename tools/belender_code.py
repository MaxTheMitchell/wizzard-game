import math


def take_all_photos(name):
    for i, camera in enumerate(get_cameras()):
        bpy.context.scene.camera = camera
        bpy.context.scene.render.filepath = "/home/max/blender/auto/{}{}.png".format(
            name, i)
        bpy.ops.render.render(write_still=True)


def get_cameras():
    return [obj for obj in bpy.data.objects if obj.type == "CAMERA"]


def create_cameras(target, cir):
    for p in pos_combos(cir):
        bpy.ops.object.camera_add(
            enter_editmode=False,
            location=[*p, 0]
        )
        track_to = bpy.context.object.constraints.new('TRACK_TO')
        track_to.target = target
        track_to.track_axis = 'TRACK_NEGATIVE_Z'
        track_to.up_axis = 'UP_Y'
        bpy.context.scene.camera = bpy.context.object


def pos_combos(cir, amount=4):
    combos = []
    deg = 0
    for _ in range(amount * 4):
        deg += math.pi / (2 * amount)
        combos.append(find_pos(cir, deg))
    return combos


def find_pos(cir, deg):
    return [
        cir/2 * math.cos(deg),
        cir/2 * math.sin(deg)
    ]


def get_mesh():
    for obj in bpy.data.objects:
        if obj.type == "MESH":
            return obj
