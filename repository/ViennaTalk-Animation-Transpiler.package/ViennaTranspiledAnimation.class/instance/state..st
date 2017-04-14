private
state: aDictionary
	object
		viennaAtomic: [ aDictionary keysAndValuesDo: [ :var :val | [self at: var put: val] on: Error do: [ :ex | ex resume ] ] ]