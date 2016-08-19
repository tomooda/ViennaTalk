private
createTranslator
	^ [ :string | 
	| generator |
	generator := ViennaVDM2SmalltalkScript new
		runtimeTypeCheck: runtimeTypeCheck state;
		runtimeAssertionCheck: runtimeAssertionCheck state;
		yourself.
	generator
		translate: string
		ifError: [ 
			generator
				translateStatement: string
				ifError: [ ViennaVDM2SmalltalkScript translateExpression: string ifError: [ :err | err ] ] ] ]