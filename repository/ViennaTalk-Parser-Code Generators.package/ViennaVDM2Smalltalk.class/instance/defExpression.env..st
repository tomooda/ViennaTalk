code generation-expressions
defExpression: aViennaNode env: aDictionary
	| definitionList defs expr vars |
	definitionList := ViennaNode label: aViennaNode first label withAll: (self reorderDefinitions: aViennaNode first).
	defs := self generate: definitionList env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	vars := (self boundVariables: aViennaNode first) asArray.
	^ '[|' , (' ' join: vars) , '|' , ('.' join: defs) , ' ifFalse: [ViennaNoMatch signal].' , expr , '] value'