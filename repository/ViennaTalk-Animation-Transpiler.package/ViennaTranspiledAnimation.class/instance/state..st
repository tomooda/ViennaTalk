private
state: aDictionary
	object
		viennaAtomic: [ aDictionary keysAndValuesDo: [ :var :val | [self at: var put: (reader parse: val)] on: Error do: [ :ex | ex resume ] ] ]