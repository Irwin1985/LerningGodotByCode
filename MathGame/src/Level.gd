extends Node2D

# cargando la clase en memoria
const MathClass = preload("res://src/Math.gd")

# crear la variable
var MathObj


func _ready():
	OS.center_window()
	_fill_combo()
	randomize()	
	
	# crear la instancia
	MathObj = MathClass.new()
#	MathObj.Reset()
#	MathObj.GenerateExpression([2, 1], randi() % 4)
#	print(MathObj.Print())
	
#	for i in range(1, 5):
#		MathObj.Reset()
#		# crear la expresión aritmética
#		MathObj.GenerateExpression(i, randi() % 4)
#		print(MathObj.Print())

# llenar el combo con los items (sumar, restar, etc)
func _fill_combo():
	$Control/OptionButton.add_item("Sumar")
	$Control/OptionButton.add_item("Restar")
	$Control/OptionButton.add_item("Multiplicar")
	$Control/OptionButton.add_item("Dividir")


func _on_Button_pressed():
	var operator = $Control/OptionButton.selected
	var leftExp = int($Control/LeftExp.text)
	var rightExp = int($Control/RightExp.text)
	
	MathObj.Reset()
	MathObj.GenerateExpression([leftExp, rightExp], operator)
	$Control/OptionButton/Button/Label.text = MathObj.Print()
