accessing
current
	^ Current ifNil: [ Current := self default ]