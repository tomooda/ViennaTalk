code generation-expressions
apply: aViennaNode
	| func args |
	func := self generate: aViennaNode first.
	args := self generate: aViennaNode second.
	^ '(' , func , ' applyTo: {' , (' . ' join: args) , '})'