field list
fieldList
	^ self selectedModule
		ifNil: [ animation state keys asSortedCollection asArray ]
		ifNotNil: [ :module | 
			| m |
			m := module , '`'.
			(animation state keys
				select: [ :name | name size > m size and: [(name copyFrom: 1 to: m size) = m ]]
				thenCollect: [ :name | name copyFrom: m size + 1 to: name size ]) asSortedCollection asArray ]