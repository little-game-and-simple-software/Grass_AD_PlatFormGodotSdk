extends Node2D

#草根广告联盟 给godot使用的接入代码
#php存放在三丰云免费虚拟主机上面，有效期一个月
#通过此代码，可以从github或者免费图床上面返回广告文件的地址

#每次请求，随机获得一张广告图片的地址，这时候只需要解码获得的byte字节，转换为Image就可以在godot里面显示这张图片了

#返回的url地址

#由于使用是免费免备案域名 免费虚拟主机 所以有时候会遇到不稳定的问题
#这种情况下，多尝试几下
var response
# Called when the node enters the scene tree for the first time.
func _ready():
	var state=$getImageUrlRequest.request("http://sfy.87si.cn/")
	if state==OK:
		print_debug("成功请求")
	else:
		print_debug("发生错误！")
	pass # Replace with function body.
	
# warning-ignore:unused_argument
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print_debug(result)
	print_debug("返回状态码",response_code)
	print_debug(body)
	response = body.get_string_from_utf8()
	print_debug(response)
	$getImageRequest.request(response)
	
	pass # Replace with function body.


func _on_getImageRequest_request_completed(result, response_code, headers, body):
	var image = Image.new()
	var error1 = image.load_jpg_from_buffer(body)
	if error1 != OK:
		print("Couldn't load the image.")
		var error2=image.load_webp_from_buffer(body)
		if error2 !=OK:
			var error3=image.load_png_from_buffer(body)
			if error3!=OK:
				print("不支持的图片格式")
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	$TextureRect.texture=texture
	pass # Replace with function body.
