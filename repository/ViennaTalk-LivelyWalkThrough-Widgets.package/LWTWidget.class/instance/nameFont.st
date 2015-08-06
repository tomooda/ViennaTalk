accessing
nameFont
	^ nameFont ifNil: [ nameFont := self defaultNameFont ]