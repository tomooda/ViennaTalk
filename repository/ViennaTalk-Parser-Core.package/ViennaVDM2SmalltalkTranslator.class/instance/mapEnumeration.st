parsers-expressions-basics
mapEnumeration
	^ super mapEnumeration
		==> [ :pairs | 
			'(Dictionary new ' , (';' join: (pairs collect: [ :pair | 'at: ' , pair first , ' put: ' , pair second ]))
				, (pairs ifEmpty: [ ')' ] ifNotEmpty: [ '; yourself)' ]) ]