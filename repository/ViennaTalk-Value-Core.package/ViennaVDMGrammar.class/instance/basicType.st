parsers-types
basicType
	^ self
		reserved:
			'bool' asParser / 'nat1' asParser / 'nat' asParser / 'int' asParser / 'real' asParser / 'char' asParser
				/ 'token' asParser