defaults
default
	^ (self alwaysUsesViennaServerAsDefault
		or: [ Smalltalk wordSize > 4 or: [ Smalltalk os isWindows or: [ ViennaVDMJ isInstalled not ] ] ])
		ifTrue: [ ViennaClient default ]
		ifFalse: [ ViennaVDMJ new ]