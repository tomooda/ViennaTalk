accessing
basename
	^ basename ifNil: [ basename := self defaultBasename ]