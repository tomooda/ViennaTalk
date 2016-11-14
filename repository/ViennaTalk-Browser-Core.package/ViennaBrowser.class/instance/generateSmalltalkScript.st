module list menu
generateSmalltalkScript
	self selectedModule
		ifNotNil: [ :module | 
			((self modulePositionsFrom: animation specification) detect: [ :assoc | assoc key = module ] ifNone: [  ])
				ifNotNil: [ :assoc | 
					| ast |
					ast := ViennaVDMParser new parse: (animation specification copyFrom: assoc value first to: assoc value last).
					ast isPetitFailure
						ifTrue: [ ^ UIManager default alert: 'Failed to generate a code : ' , ast message title: 'ViennaTalk' ].
					ast first label = 'Module'
						ifTrue: [ 
							ast := ast first third copy
								setLabel: 'Document';
								yourself ].
					(ViennaVDM2SmalltalkScript new generate: ast)
						ifNotNil: [ :script | Smalltalk tools workspace openContents: (RBParser parseExpression: script) formattedCode ] ] ]