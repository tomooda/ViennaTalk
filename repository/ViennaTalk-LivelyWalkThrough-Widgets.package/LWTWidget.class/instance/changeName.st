operations
changeName
	(UIManager default request: 'Enter a new name' initialAnswer: self name) ifNotNil: [ :newName | self name: newName ]