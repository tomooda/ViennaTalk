sole instance
current
	^ current ifNil: [ current := self new ]