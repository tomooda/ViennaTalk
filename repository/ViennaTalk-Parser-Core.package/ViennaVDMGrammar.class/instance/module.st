parsers-definitions
module
	^ ((self reserved: 'module') , identifier trim , self interface , self moduleBody optional , (self reserved: 'end')
		, identifier)
		==> [ :array | 
			array second = array sixth
				ifTrue: [ 
					{(array second).
					(array third).
					(array fourth)} ]
				ifFalse: [ PPFailure message: 'module name (' , array second , ') and end name (' , array sixth , ') do not agree.' ] ]