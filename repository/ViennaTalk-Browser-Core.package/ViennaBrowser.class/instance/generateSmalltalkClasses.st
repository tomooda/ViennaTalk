module list menu
generateSmalltalkClasses
	| ast |
	ast := ViennaVDMParser new parse: animation specification.
	ast isPetitFailure
		ifTrue: [ ^ UIManager default alert: 'Failed to generate a code : ' , ast message title: 'ViennaTalk' ].
	(ViennaVDM2SmalltalkClass new generate: ast) ifNotNil: [ :class | class browse ]