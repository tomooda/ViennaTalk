module list menu
generateSmalltalkObject
	| ast |
	ast := ViennaVDMParser new parse: vdmc specification.
	ast isPetitFailure
		ifTrue: [ ^ UIManager default
				alert: 'Failed to generate a code : ' , ast message
				title: 'ViennaTalk' ].
	(ViennaVDM2SmalltalkObject new generate: ast) ifNotNil: [ :object | object inspect ]