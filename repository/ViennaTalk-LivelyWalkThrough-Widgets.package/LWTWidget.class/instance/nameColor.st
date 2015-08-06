accessing
nameColor
	^ nameColor ifNil: [ nameColor := self defaultNameColor ]