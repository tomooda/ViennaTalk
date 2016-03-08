module list menu
generateSmalltalkScript
	self selectedModule
		ifNotNil: [ :module | 
			((self modulePositionsFrom: vdmc specification) detect: [ :assoc | assoc key = module ] ifNone: [  ])
				ifNotNil: [ :assoc | 
					| ast |
					ast := ViennaVDMParser new parse: (vdmc specification copyFrom: assoc value first to: assoc value last).
					ast first label = 'Module'
						ifTrue: [ 
							ast := ast first third copy
								setLabel: 'Document';
								yourself ].
					(ViennaVDM2SmalltalkScript new generate: ast)
						ifNotNil: [ :script | Smalltalk tools workspace openContents: (RBParser parseExpression: script) formattedCode ] ] ]