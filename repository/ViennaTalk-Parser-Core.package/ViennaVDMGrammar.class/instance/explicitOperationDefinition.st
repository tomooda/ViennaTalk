parsers-definitions
explicitOperationDefinition
	^ (identifier , colon , self operationType , identifier , self parameters , (self operator: '==') , self operationBody
		, (((self reserved: 'pre') , expression) ==> #second) optional
		, (((self reserved: 'post') , expression) ==> #second) optional)
		==> [ :array | 
			array first = array fourth
				ifTrue: [ 
					{(array first).
					(array third).
					(array fourth).
					(array fifth).
					(array seventh).
					(array eighth).
					(array ninth)} ]
				ifFalse: [ PPFailure message: 'operation name mismatch : ' , array first , ',' , array fourth ] ]