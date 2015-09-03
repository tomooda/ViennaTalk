operations
changeUrl
	(UIManager default request: 'Enter a new URL' initialAnswer: self url) ifNotNil: [ :newUrl | self url: newUrl ]