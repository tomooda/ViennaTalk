code generation-statements
callStatement: aViennaNode env: aDictionary
	| callee args |
	callee := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ callee , ' valueWithArguments: {' , (' . ' join: args) , '}'