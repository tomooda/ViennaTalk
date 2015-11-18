parsers-expressions-basics
tupleConstructor
	^ super tupleConstructor
		==> [ :array | 
			'((Array new: ' , array size storeString , ') '
				, (';' join: ((1 to: array size) collect: [ :i | 'at: ' , i storeString , ' put: ' , (array at: i) ]))
				, '; yourself)' ]