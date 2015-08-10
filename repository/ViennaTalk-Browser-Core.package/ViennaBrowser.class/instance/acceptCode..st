code pane
acceptCode: aString
	vdmc
		ifNotNil: [ 
			aString asString ~= cachedSpec
				ifTrue: [ 
					| newModules oldModules source oldSpecification |
					cachedSpec := aString asString.
					oldModules := cachedModulePositions ifNil: [ self modulePositionsFrom: vdmc specification ].
					cachedModulePositions := self modulePositionsFrom: aString asString.
					newModules := Dictionary new.
					cachedModulePositions do: [ :assoc | newModules at: assoc key put: assoc value ].
					source := String new writeStream.
					source nextPutAll: (vdmc specification copyFrom: 1 to: oldModules first value first - 1).
					oldModules
						do: [ :assoc | 
							(newModules includesKey: assoc key)
								ifTrue: [ 
									| section |
									section := newModules at: assoc key.
									source nextPutAll: (aString copyFrom: section first to: section last).
									newModules removeKey: assoc key ]
								ifFalse: [ 
									| section |
									section := assoc value.
									source nextPutAll: (vdmc specification copyFrom: section first to: section last) ] ].
					(newModules associations asSortedCollection: [ :less :more | less value first < more value first ])
						do: [ :assoc | 
							| section |
							section := assoc value.
							source nextPutAll: (aString copyFrom: section first to: section last) ].
					oldSpecification := vdmc specification.
					vdmc specification: source contents.
					[ vdmc plainEvaluate: 'nil' ]
						on: Error
						do: [ :ex | 
							vdmc specification: oldSpecification.
							codePane
								handleEdit: [ 
									codePane textMorph editor
										in: [ :editor | 
											editor selectFrom: editor caret to: editor caret - 1.
											editor afterSelectionInsertAndSelect: ex messageText ] ].
							^ false ].
					self changed: #moduleList.
					self changed: #fieldList.
					self changed: #value.
					^ true ] ].
	^ false