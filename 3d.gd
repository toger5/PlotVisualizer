extends Spatial


var shader = Shader.new()
var shader_mat

func _ready():
	shader_mat = ShaderMaterial.new()#$Graph.get_surface_material(0)
	shader_mat.shader = shader
	set_func("cos(10.0*x)/3.0 + cos(10.0*y)/3.0")
func set_func(function):
	function =function.replace("x", "VERTEX.x")
	function =function.replace("y", "VERTEX.z")
	shader.code = "shader_type spatial;\n" + \
	 "void vertex() {" +\
  "VERTEX.y += "+function+";}"
				#"void fragment() {\n" + \
				#" VERTEX.y += " + function + ";}"
				#"\tCOLOR.rgba = vec4(0.5,0.0,0.0,1.0);\n}"
	#print(shader.code)
	$Graph.material_override = shader_mat