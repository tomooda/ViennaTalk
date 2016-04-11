code generation-expressions
apply: aViennaNode env: aDictionary
	| func args |
	func := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ '(' , func , ' applyTo: {' , (' . ' join: args) , '})'