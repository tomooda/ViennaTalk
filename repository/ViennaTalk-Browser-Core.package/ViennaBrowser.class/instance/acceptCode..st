code pane
acceptCode: aStringOrText
	vdmc
		ifNotNil: [ 
			| code oldModulePositions oldModuleNames newModulePositions newModuleDict oldSpec newSpec |
			code := aStringOrText asString.
			oldSpec := vdmc specification.
			oldModulePositions := self modulePositionsFrom: oldSpec.
			oldModuleNames := (oldModulePositions collect: #key) asSet.
			newModulePositions := self modulePositionsFrom: code.
			newModuleDict := Dictionary new.
			newModulePositions do: [ :assoc | newModuleDict at: assoc key put: assoc value ].
			newSpec := String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: (oldSpec copyFrom: 1 to: oldModulePositions first value first - 1).
					oldModulePositions
						do: [ :assoc | 
							newModuleDict
								at: assoc key
								ifPresent: [ :range | stream nextPutAll: (code copyFrom: range first to: range last) ]
								ifAbsent: [ stream nextPutAll: (oldSpec copyFrom: assoc value first to: assoc value last) ] ].
					newModulePositions
						do: [ :assoc | 
							(oldModuleNames includes: assoc key)
								ifFalse: [ stream nextPutAll: (code copyFrom: assoc value first to: assoc value last) ] ] ].
			vdmc specification: newSpec.
			[ vdmc plainEvaluate: 'nil' ]
				on: Error
				do: [ :ex | 
					vdmc specification: oldSpec.
					codePane
						handleEdit: [ 
							codePane textMorph editor
								in: [ :editor | 
									editor selectFrom: editor caret to: editor caret - 1.
									editor afterSelectionInsertAndSelect: ex messageText ] ].
					^ false ].
			codePane hasUnacceptedEdits: false.
			self changed: #moduleList.
			self selectModuleNamed: newModulePositions first key.
			^ true ].
	^ false