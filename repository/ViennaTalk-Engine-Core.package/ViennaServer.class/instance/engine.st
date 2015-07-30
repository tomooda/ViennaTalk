accessing
engine
	^ engine ifNil: [ engine := self defaultEngine ]