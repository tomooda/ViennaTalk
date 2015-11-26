*ViennaTalk-Value-Core
** anInteger
	| dict |
	dict := Dictionary new.
	self
		keysDo: [ :key | 
			| value |
			value := key.
			anInteger timesRepeat: [ value := self at: value ].
			dict at: key put: value ].
	^ dict