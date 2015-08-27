validating
validate: aString do: aBlock ifError: errorBlock
	type = #number
		ifTrue: [ 
			| vdm |
			vdm := [ ViennaWriter new stringify: (ViennaReader new parseNumberOn: aString trim readStream) ]
				on: Error
				do: [ :ex | ^ errorBlock value: 'Cannot convert to VDM number' ].
			^ aBlock value: vdm ].
	type = #vdm
		ifTrue: [ 
			| vdm |
			vdm := [ ViennaWriter new stringify: (ViennaReader new parse: aString) ]
				on: Error
				do: [ :ex | ^ errorBlock value: 'Cannot convert to VDM value' ].
			^ aBlock value: vdm ].
	^ aBlock value: aString