parsers-expressions-basics
oldName
	^ super oldName ==> [ :string | ViennaNode label: 'OldName' with: (string copyFrom: 1 to: string size - 1) ]