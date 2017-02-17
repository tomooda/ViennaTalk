evaluating
evaluateStatement: aString with: aViennaVDM2SmalltalkClass ifError: errorBlock
	| src |
	src := self class
		transpileStatement: aString
		with: aViennaVDM2SmalltalkClass
		ifError: [ :msg | ^ errorBlock cull: msg ].
	^ Compiler evaluate: src for: self logged: false