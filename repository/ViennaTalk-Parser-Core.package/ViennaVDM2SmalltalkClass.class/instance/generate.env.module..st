code generation
generate: aViennaNode env: aDictionary module: aString
	| selector |
	selector := aViennaNode label uncapitalized , ':env:module:'.
	^ self
		perform: selector asSymbol
		with: aViennaNode
		with: aDictionary
		with: aString