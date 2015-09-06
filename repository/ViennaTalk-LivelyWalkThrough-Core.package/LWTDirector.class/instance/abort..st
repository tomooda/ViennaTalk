dialogs
abort: aString
	| context |
	context := thisContext.
	[ context receiver isKindOf: LWTLivetalkScript ] whileFalse: [ context := context sender ].
	UIManager default abort: aString title: 'Lively Walk-Through: ' , context receiver name.
	context return: nil