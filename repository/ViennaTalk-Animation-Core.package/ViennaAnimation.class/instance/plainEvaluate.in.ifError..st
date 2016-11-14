evaluating
plainEvaluate: aString in: moduleName ifError: errorBlock
	| result |
	lock critical: [ result := self basicPlainEvaluate: aString in: moduleName ifError: [ :msg | ^ errorBlock cull: msg ] ].
	self changed: #state.
	^ result