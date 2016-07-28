code generation-expressions
letExpression: aViennaNode env: aDictionary
	| definitionList localDefinitions body vars |
	definitionList := ViennaNode label: aViennaNode first label withAll: (self reorderDefinitions: aViennaNode first).
	localDefinitions := self generate: definitionList env: aDictionary.
	body := self generate: aViennaNode second env: aDictionary.
	vars := (self boundVariables: definitionList) asArray.
	^ '[|' , (' ' join: vars) , '|' , ('. ' join: localDefinitions) , '. ' , body , '] value'