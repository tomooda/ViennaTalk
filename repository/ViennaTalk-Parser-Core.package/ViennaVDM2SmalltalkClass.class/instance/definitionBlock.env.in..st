code generation-definitions
definitionBlock: aViennaNode env: aDictionary in: aClass
	aViennaNode
		do: [ :node | 
			self
				perform: (node label uncapitalized , ':env:in:') asSymbol
				with: node
				with: aDictionary
				with: aClass ]