accessing
plainAt: aString ifPresent: presentBlock
	^ self
		plainAt: aString
		ifPresent: [ :value | presentBlock value: value viennaString ]
		ifAbsent: [  ]