defaults
default
	^ (Smalltalk os isWindows not and: [ ViennaVDMJ isInstalled ])
		ifTrue: [ ViennaVDMJ new ]
		ifFalse: [ ViennaClient default ]