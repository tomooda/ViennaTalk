defaults
default
	^ (self alwaysUsesViennaServerAsDefault
		or: [ Smalltalk os isWindows or: [ ViennaVDMJ isInstalled not ] ])
		ifTrue: [ ViennaClient default ]
		ifFalse: [ ViennaVDMJ new ]