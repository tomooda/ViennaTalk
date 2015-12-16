parsers-definitions
typeVariableList
	^ (lbracket , (self typeVariableIdentifier separatedBy: comma) withoutSeparators , rbracket) optional ==> [:tripleOrNil | tripleOrNil ifNil: [#()] ifNotNil: [tripleOrNil second]]