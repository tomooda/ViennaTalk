accessing
parse: aStringOrText onError: errorBlock
	self text: aStringOrText asText.
	(self parse: aStringOrText asString) isPetitFailure
		ifFalse: [ ^ self text ].
	(self accessTypeDefinition parse: aStringOrText asString) isPetitFailure
		ifFalse: [ ^ self text ].
	(self accessValueDefinition parse: aStringOrText asString) isPetitFailure
		ifFalse: [ ^ self text ].
	(self stateDefinition parse: aStringOrText asString) isPetitFailure
		ifFalse: [ ^ self text ].
	(self accessFunctionDefinition parse: aStringOrText asString) isPetitFailure
		ifFalse: [ ^ self text ].
	(self accessOperationDefinition parse: aStringOrText asString) isPetitFailure
		ifFalse: [ ^ self text ].
	(self statement parse: aStringOrText asString) isPetitFailure
		ifFalse: [ ^ self text ].
	(self expression parse: aStringOrText asString) isPetitFailure
		ifFalse: [ ^ self text ].
	^ errorBlock value