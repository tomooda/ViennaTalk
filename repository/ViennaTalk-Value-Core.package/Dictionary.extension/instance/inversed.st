*ViennaTalk-Value-Core
inversed
	| dict |
	dict := Dictionary new.
	self keysAndValuesDo: [ :key :value | dict at: value put: key ].
	^ dict