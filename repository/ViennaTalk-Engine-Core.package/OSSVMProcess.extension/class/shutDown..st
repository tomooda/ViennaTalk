*ViennaTalk-Engine-Core
shutDown: quitting
	Smalltalk platform isWindows not
		ifTrue: [ ^ self ].
	self vmProcess shutDown: quitting