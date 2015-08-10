field list
fieldList
	^ self selectedModule
		ifNil: [ vdmc state keys asSortedCollection asArray ]
		ifNotNil: [ :module | 
			| m |
			m := module , '`'.
			(vdmc state keys
				select: [ :name | (name copyFrom: 1 to: m size) = m ]
				thenCollect: [ :name | name copyFrom: m size + 1 to: name size ]) asSortedCollection asArray ]