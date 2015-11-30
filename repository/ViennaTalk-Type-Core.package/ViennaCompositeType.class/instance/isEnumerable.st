testing
isEnumerable
	1 to: self size do: [ :index | 
		(self basetypeAt: index) isEnumerable
			ifFalse: [ ^ false ] ].
	^ true