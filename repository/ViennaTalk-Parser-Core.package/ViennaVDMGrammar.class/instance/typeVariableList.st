parsers-definitions
typeVariableList
	^ (lbracket , (self typeVariableIdentifier separatedBy: comma) withoutSeparators , rbracket) ==> #second