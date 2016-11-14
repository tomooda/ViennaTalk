private
state
	| state |
	state := Dictionary new.
	object
		ifNotNil: [ object isDictionary
				ifTrue: [ object
						keysAndValuesDo: [ :moduleName :module | 
							| moduleState |
							moduleState := module state.
							moduleState namedFields
								keysAndValuesDo:
									[ :varName :varIndex | state at: moduleName , '`' , varName put: (writer stringify: (moduleState at: varIndex)) ] ] ]
				ifFalse: [ | moduleState |
					moduleState := object state.
					moduleState namedFields
						keysAndValuesDo:
							[ :varName :varIndex | state at: self defaultModule, '`', varName put: (writer stringify: (moduleState at: varIndex)) ] ] ].
	^ state