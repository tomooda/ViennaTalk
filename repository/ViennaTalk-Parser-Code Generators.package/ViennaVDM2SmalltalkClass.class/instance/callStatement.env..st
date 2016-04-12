code generation-statements
callStatement: aViennaNode env: aDictionary
	| callee args |
	callee := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ args
		ifEmpty: [ callee , ': nil' ]
		ifNotEmpty: [ callee , ': ' , args first , ('' join: ((2 to: args size) collect: [ :i | ' _: ' , (args at: i) ])) ]