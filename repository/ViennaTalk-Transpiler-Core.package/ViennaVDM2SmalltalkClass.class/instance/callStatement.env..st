code generation-statements
callStatement: aViennaNode env: aDictionary
	| callee args |
	callee := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ args
		ifEmpty: [ callee , ' value' ]
		ifNotEmpty: [ '(', callee , ' value: ', (' value: ' join: args), ')' ]