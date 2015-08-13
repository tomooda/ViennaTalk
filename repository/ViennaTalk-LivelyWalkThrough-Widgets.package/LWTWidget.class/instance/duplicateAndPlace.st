operations
duplicateAndPlace
	^ (UIManager default request: 'Enter a new name' initialAnswer: self name)
		ifNotNil: [ :newName | 
			| duplicate |
			duplicate := self duplicate
				name: newName;
				top: self bottom.
			self director addMorph: duplicate.
			duplicate ]