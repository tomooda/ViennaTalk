field list
fieldList
	^ state
		ifNil: [Array new]
		ifNotNil: [:s | s
				collect: [:fieldAndValue | fieldAndValue key]]