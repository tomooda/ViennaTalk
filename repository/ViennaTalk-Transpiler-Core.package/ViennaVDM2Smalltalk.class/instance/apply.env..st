code generation-expressions
apply: aViennaNode env: aDictionary
	| func args |
	func := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ args
		ifEmpty: [ func , ' value' ]
		ifNotEmpty: [ args size <= 4
				ifTrue: [ '(' , func , ' value: ' , (' value: ' join: args) , ')' ]
				ifFalse: [ '(' , func , ' valueWithArguments: {' , (' . ' join: args) , '})' ] ]