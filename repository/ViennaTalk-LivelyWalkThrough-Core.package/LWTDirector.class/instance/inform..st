dialogs
inform: aString
	| context |
	context := thisContext.
	[ context receiver isKindOf: LWTAction ] whileFalse: [ context := context sender ].
	UIManager default alert: aString title: 'Lively Walk-Through: ' , context receiver name