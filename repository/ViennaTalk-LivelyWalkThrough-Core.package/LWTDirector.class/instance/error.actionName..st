dialogs
error: aString actionName: nameString
	| context |
	UIManager default abort: aString title: 'Lively Walk-Through: ' , nameString.
	context := thisContext.
	[ context receiver isKindOf: LWTAction ] whileFalse: [ context := context sender ].
	context return: nil