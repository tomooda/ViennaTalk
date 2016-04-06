parsers-definitions
module
	^ (self moduleKeyword , (self decl: self moduleIdentifier) trim , self interface , self moduleBody optional
		, self endKeyword , self moduleIdentifier)
		==> [ :array | 
			array second = array sixth
				ifTrue: [ 
					{(array second).
					(array third).
					(array fourth)} ]
				ifFalse: [ PPFailure message: 'module name (' , array second , ') and end name (' , array sixth , ') do not agree.' ] ]