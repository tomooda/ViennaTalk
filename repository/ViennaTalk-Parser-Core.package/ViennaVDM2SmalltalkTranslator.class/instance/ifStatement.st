parsers-statements
ifStatement
	^ super ifStatement
		==> [ :pair | 
			pair first
				inject: (pair second ifNil: [ '' ])
				into: [ :else :cond | cond first , ' ifTrue: [' , cond second , '] ifFalse: [' , else , ']' ] ]