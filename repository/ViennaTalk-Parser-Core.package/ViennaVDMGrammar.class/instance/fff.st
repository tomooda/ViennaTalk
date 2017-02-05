parsers-definitions
fff
	^ identifier trim , self parameterTypes
		, (self identifierTypePairList optional ==> [ :list | list ifNil: [ Array new ] ])
		, (((self operator: '==') , self operationBody) ==> #second)
		, ((self pre , expression) ==> #second) optional , ((self post , expression) ==> #second)
		, ((self errs , self exceptions) ==> #second) optional