accessing
translator
	^ translator ifNil: [ translator := self createTranslator ]