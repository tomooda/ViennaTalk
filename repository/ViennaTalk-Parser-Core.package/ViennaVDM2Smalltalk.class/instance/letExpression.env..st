code generation-expressions
letExpression: aViennaNode env: aDictionary
	| definitionList localDefinitions body vars |
	definitionList := ViennaNode label: aViennaNode first label withAll: (self reorderDefinitions: aViennaNode first).
	localDefinitions := self generate: definitionList env: aDictionary.
	body := self generate: aViennaNode second env: aDictionary.
	vars := Array new: 10 streamContents: [ :stream | localDefinitions do: [ :def | stream nextPutAll: def first ] ].
	^ '[|' , (' ' join: vars) , '|' , ('.' join: (localDefinitions collect: #second)) , '.' , body , '] value'