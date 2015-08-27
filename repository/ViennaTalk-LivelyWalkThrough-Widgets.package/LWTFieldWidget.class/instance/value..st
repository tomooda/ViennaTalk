accessing
value: aStringOrText
	self acceptContents: (self valueToContents: aStringOrText).
	self changed: #contents