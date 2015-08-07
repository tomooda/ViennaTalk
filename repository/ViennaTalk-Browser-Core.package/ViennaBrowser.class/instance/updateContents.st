value pane
updateContents
	| newContents |
	newContents := (selectedField
		ifNotNil: [ 
			(state detect: [ :fieldAndValue | fieldAndValue key = selectedField ] ifNone: [  ])
				ifNotNil: [ :fieldAndValue | fieldAndValue value ] ])
		ifNil: [ 
			selectedModule
				ifNil: [ String new ]
				ifNotNil: [ :module | 
					| content |
					content := String new writeStream.
					content nextPut: ${.
					state
						do: [ :nameAndValue | 
							content
								nextPut: $';
								nextPutAll: nameAndValue key;
								nextPut: $';
								nextPutAll: ' -> ';
								nextPut: $';
								nextPutAll: nameAndValue value;
								nextPut: $' ]
						separatedBy: [ 
							content
								space;
								nextPut: $.;
								cr ].
					content nextPut: $}.
					content contents ] ].
	newContents ~= vdmc specification
		ifTrue: [ 
			vdmc specification: newContents.
			self changed: #contents ]