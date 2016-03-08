module list menu
generateSmalltalkClasses
	| ast |
	ast := ViennaVDMParser new parse: vdmc specification.
	(ViennaVDM2SmalltalkClass new generate: ast) ifNotNil: [ :class | class browse ]