code pane
acceptCode: aStringOrText
	vdmc
		ifNotNil: [ 
			| code oldModulePositions newModulePositions newModuleNames oldSpec newSpec |
			code := (self autoFormat
				ifTrue: [ 
					(ViennaVDMParser new format: aStringOrText)
						in: [ :formatted | 
							formatted isPetitFailure
								ifTrue: [ aStringOrText ]
								ifFalse: [ formatted ] ] ]
				ifFalse: [ aStringOrText ]) asString trimmed copyWith: Character cr.
			oldSpec := vdmc specification.
			oldModulePositions := self modulePositionsFrom: oldSpec.
			newModulePositions := self modulePositionsFrom: code.
			newModuleNames := (newModulePositions collect: #key) asSet.
			newSpec := String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: code.
					oldModulePositions
						do: [ :assoc | 
							(newModuleNames includes: assoc key)
								ifFalse: [ stream nextPutAll: (oldSpec copyFrom: assoc value first to: assoc value last) ] ] ].
			codePane hasUnacceptedEdits: false.
			vdmc
				specification: newSpec
				ifError: [ :msg | 
					| posStrIndex charPos message |
					charPos := 0.
					message := msg.
					posStrIndex := msg findLastOccurrenceOfString: 'at line ' startingAt: 1.
					posStrIndex > 0
						ifTrue: [ 
							| colonIndex |
							colonIndex := msg indexOf: $: startingAt: posStrIndex + 9.
							colonIndex > 0
								ifTrue: [ 
									| linePos colPos lines |
									message := msg copyFrom: 1 to: posStrIndex - 1.
									(message includes: $()
										ifTrue: [ message := message copyFrom: 1 to: (message findLastOccurrenceOfString: ' (' startingAt: 1) ].
									linePos := (msg copyFrom: posStrIndex + 8 to: colonIndex - 1) asInteger.
									colPos := (msg copyFrom: colonIndex + 1 to: msg size) asInteger.
									lines := code lines.
									linePos <= lines size
										ifTrue: [ charPos := (((lines copyFrom: 1 to: linePos - 1) collect: #size) + 1) sum + colPos ] ] ].
					^ codePane handleEdit: [ codePane notify: message at: charPos in: code readStream ] ].
			codePane hasUnacceptedEdits: false.
			self selectModuleNamed: (newModulePositions ifEmpty: [ nil ] ifNotEmpty: [ newModulePositions first key ]).
			^ true ].
	^ false