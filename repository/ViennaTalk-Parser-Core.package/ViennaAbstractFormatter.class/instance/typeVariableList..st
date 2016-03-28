formatting-definitions
typeVariableList: aViennaNode
	^ aViennaNode size > 0
		ifTrue: [ '[' , (String space join: (self formatAll: aViennaNode)) , ']' ]
		ifFalse: [ '' ]