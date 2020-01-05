import os
import shutil
import json

avatar_file_path = '/Users/tongchao/Downloads/avatars'

origin_avatar_names = os.listdir(avatar_file_path)
avatar_names = set()

for name in origin_avatar_names:
    name = name.replace('.png', '').replace('@2x', '').replace('@3x', '')
    avatar_names.add(name)

project_file_path = '/Users/tongchao/Documents/ms/contacts'
assets_path = project_file_path + '/contacts/Assets.xcassets'

os.chdir(assets_path)
os.mkdir('avatar')

avatars_path = assets_path + '/avatar'
os.chdir(avatars_path)

content_json = {
  "images" : [
    {
      "idiom" : "universal",
      "filename" : "image_file_name",
      "scale" : "1x"
    },
    {
      "idiom" : "universal",
      "filename" : "image_file_2x_name",
      "scale" : "2x"
    },
    {
      "idiom" : "universal",
      "filename" : "image_file_3x_name",
      "scale" : "3x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}

for name in avatar_names:
    if name.startswith('.'):
        continue
    image_set_dir = name + '.imageset'
    os.mkdir(image_set_dir)

    image_path = avatar_file_path + '/' + name + '.png'
    image_2x_path = avatar_file_path + '/' + name + '@2x' + '.png'
    image_3x_path = avatar_file_path + '/' + name + '@3x' + '.png'

    shutil.copyfile(image_path, image_set_dir + '/' + name + '.png')
    shutil.copyfile(image_2x_path, image_set_dir + '/' + name + '@2x' + '.png')
    shutil.copyfile(image_3x_path, image_set_dir + '/' + name + '@3x' + '.png')

    content_json['images'][0]['filename'] = name + '.png'
    content_json['images'][1]['filename'] = name + '@2x' + '.png'
    content_json['images'][2]['filename'] = name + '@3x' + '.png'

    with open(image_set_dir + '/Contents.json', 'w') as fp:
        json.dump(content_json, fp)
    
