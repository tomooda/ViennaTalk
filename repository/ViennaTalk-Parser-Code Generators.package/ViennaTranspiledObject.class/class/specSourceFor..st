specification
specSourceFor: aViennaNode
	^ specification
		ifNil: [ ViennaVDMFormatter new format: aViennaNode ]
		ifNotNil: [ | start end |
			start := aViennaNode start.
			end := aViennaNode end.
			(start isNil or: [ end isNil ])
				ifTrue: [ ViennaVDMFormatter new format: aViennaNode ]
				ifFalse: [ specification copyFrom: start to: end ] ]