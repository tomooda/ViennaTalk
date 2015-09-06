accessing
acceptContents: aStringOrText
	contents ~= aStringOrText asString trim
		ifTrue: [ 
			super acceptContents: aStringOrText.
			ZnEasy put: self url asUrl data: (ZnEntity text: aStringOrText) ].
	^ true