module list menu
generateSmalltalkObject
	| ast |
	ast := ViennaVDMParser new parse: vdmc specification.
	(ViennaVDM2SmalltalkObject new generate: ast) ifNotNil: [ :object | object inspect ]