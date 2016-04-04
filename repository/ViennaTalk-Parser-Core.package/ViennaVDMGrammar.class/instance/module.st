parsers-definitions
module
	^ (self moduleKeyword , identifier trim , self interface , self moduleBody optional , self endKeyword , identifier)
		==> [ :array | 
			array second = array sixth
				ifTrue: [ 
					{(array second).
					(array third).
					(array fourth)} ]
				ifFalse: [ PPFailure message: 'module name (' , array second , ') and end name (' , array sixth , ') do not agree.' ] ]