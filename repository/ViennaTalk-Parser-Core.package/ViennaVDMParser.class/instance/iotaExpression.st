parsers-expressions-basics
iotaExpression
	^ super iotaExpression ==> [ :array | ViennaNode label: 'IotaExpression' withAll: array ]