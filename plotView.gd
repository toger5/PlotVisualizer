extends Control
export (NodePath) var spin_min_y = null
export (NodePath) var spin_max_y = null
export (NodePath) var spin_min_x = null
export (NodePath) var spin_max_x = null
var precision = 3
var xrange = [-10,10]
var yrange = [-10,10]

var func_obj = from_string("x*10")

func sinus(x):
	#return pow(x,2)
	return sin(x)

func from_string(function_string):
	var script = GDScript.new()
	script.set_source_code("extends Object\nfunc function(x):\n\treturn " + function_string)
	script.reload()
	var obj = script.new()
	return obj

func _ready():
	update_plot()
	connect("resized",self, "update_plot")
	pass

func update_plot():
	$Line.points = []
	for x in range(rect_size.x/precision):
		var x_for_func = range_lerp(x, 0,rect_size.x/precision,xrange[0],xrange[1])
		add_point(x_for_func, func_obj.function(x_for_func))
func add_point(x,y):
	var f_x = rect_size.x / xrange()
	var f_y = rect_size.y / yrange() 
	var _x = x * (f_x)
	var _y = y * (f_y) - (yrange[0] * f_y)
	_y = rect_size.y - _y
	
	_x = range_lerp(x, xrange[0],xrange[1], 0, rect_size.x)
	_y = range_lerp(y, yrange[0],yrange[1], rect_size.y, 0)
	$Line.add_point(Vector2(_x, _y))

func xrange():
	return xrange[1] - xrange[0]
func yrange():
	return yrange[1] - yrange[0]


func _on_SpinMinY_value_changed(value):
	yrange[0] = value#get_node(spin_min_y).value

	update_plot()


func _on_SpinMaxY_value_changed(value):
	yrange[1] = value# get_node(spin_max_y).value

	update_plot()


func _on_SpinMinX_value_changed(value):
	xrange[0] = value#get_node(spin_min_y).value
	update_plot()



func _on_SpinMaxX_value_changed(value):
	xrange[1] = value#get_node(spin_min_y).value
	update_plot()



func _on_LE_fucntion_text_entered(new_text):
	print("enter")
	func_obj = from_string(new_text)
	update_plot()
