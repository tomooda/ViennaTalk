accessing
translator
	^ translator ifNil: [ translator := self translatorClass new ]