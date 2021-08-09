extends Node

class_name Math

##########################
# CONSTANTES
##########################
const EXP_LEFT_OPERAND = 0
const EXP_RIGHT_OPERAND = 1
const MIN_RANGE = 0
const MAX_RANGE = 1


enum TypeOp {
	Add, # 0
	Sub, # 1
	Mul, # 2
	Div, # 3
	Nil  # 4
}

############################
#  5       +        2
# left  operator  right
############################

var Operator
var LeftOperand
var RightOperand

var _minRange
var _maxRange


func GenerateExpression(array_exp, type):
	# update left operand
	var op_range = _get_range(array_exp[EXP_LEFT_OPERAND])	
	LeftOperand = int(rand_range(op_range[MIN_RANGE], op_range[MAX_RANGE]))
	
	# update right operand
	op_range = _get_range(array_exp[EXP_RIGHT_OPERAND])	
	RightOperand = int(rand_range(op_range[MIN_RANGE], op_range[MAX_RANGE]))
	Operator = type


func GetResult():
	match Operator:
		TypeOp.Add:
			return LeftOperand + RightOperand
		TypeOp.Sub:
			return LeftOperand - RightOperand
		TypeOp.Mul:
			return LeftOperand * RightOperand
		TypeOp.Div:
			return LeftOperand / RightOperand
		_: # en caso de no cumplirse ninguna de las anteriores.
			return LeftOperand + RightOperand


func Reset():
	LeftOperand = 0
	RightOperand = 0
	Operator = TypeOp.Nil
	

func Print():
	return str(LeftOperand) + _get_operator_str() + str(RightOperand)

func _get_operator_str():
	match Operator:
		TypeOp.Add:
			return " + "
		TypeOp.Sub:
			return " - "
		TypeOp.Mul:
			return " x "
		TypeOp.Div:
			return " / "
		_:
			return " "

# devuelve el rango (min, max) de un número positivo
func _get_range(num):
	if num == 0:
		return

	if num == 1:
		_minRange = 1
		_maxRange = 9
	else:
		# 2 -> 10 (10 pow 1)
		# 3 -> 100 (10 pow 2)
		# 4 -> 1000 (10 pow 3)
		# 5 -> 10000 (10 pow 4)
		_minRange = pow(10, num-1) # 2 => 10 pow (2-1) => 10
		_maxRange = pow(10, num) - 1 # 2 => 100 - 1 = 99
	
	return [_minRange, _maxRange]







	

