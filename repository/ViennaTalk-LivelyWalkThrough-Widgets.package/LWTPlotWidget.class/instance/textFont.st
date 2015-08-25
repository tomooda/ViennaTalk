accessing
textFont
	^ textFont ifNil: [ textFont := self defaultTextFont ]