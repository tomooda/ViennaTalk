code pane
code: aString notifying: aMorph
	vdmc
		ifNotNil: [ 
			| newModules oldModules source oldSpecification |
			newModules := Dictionary withAll: (self modulePositionsFrom: aString).
			oldModules := self modulePositionsFrom: vdmc specification.
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
			(vdmc plainEvaluate: 'nil')
				ifNil: [ 
					vdmc specification: oldSpecification.
					^ false ].
			self changed: #moduleList.
			self updateState.
			^ true ].
	^ false