code generation-definitions
explicitOperationDefinition: aViennaNode env: aDictionary
	| opname typeNode paramsNode preNode postNode body varGenerator argTypeNode binds |
	opname := aViennaNode first.
	typeNode := aViennaNode second.
	paramsNode := aViennaNode fourth.
	preNode := aViennaNode sixth.
	postNode := aViennaNode seventh.
	body := '[|_opContext| _opContext := thisContext. ' , (self generate: aViennaNode fifth env: aDictionary) , '] value'.
	preNode
		ifNotNil: [ body := (self generate: preNode env: aDictionary) , 'ifFalse: [ViennaPreconditionViolation signal]. ' , body ].
	postNode
		ifNotNil: [ 
			body := '[|_oldState RESULT| _oldState := ' , self getStateCode , '. RESULT := [' , body , '] value. ('
				, (self generate: postNode env: aDictionary) , ') ifFalse: [ViennaPostconditionViolation signal]. RESULT] value' ].
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	argTypeNode := typeNode first.
	binds := argTypeNode label = 'UnitType'
		ifTrue: [ {} ]
		ifFalse: [ 
			argTypeNode label = 'ProductType'
				ifTrue: [ 
					(1 to: argTypeNode size)
						collect: [ :index | 
							{(paramsNode at: index).
							(argTypeNode at: index)} ] ]
				ifFalse: [ 
					{{(paramsNode first).
					argTypeNode}} ] ].
	^ opname , ' := '
		,
			(self
				closureFromFlatBinds: binds
				body: body
				varGenerator: varGenerator
				env: aDictionary)