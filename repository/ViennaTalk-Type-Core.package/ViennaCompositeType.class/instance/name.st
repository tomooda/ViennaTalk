accessing
name
	^ 'compose ' , constructorName , ' of '
		,
			(' '
				join:
					(self
						fieldsCollect: [ :fieldName :equalityAbstraction :fieldType | 
							(fieldName
								ifNil: [ '' ]
								ifNotNil: [ 
									fieldName , ':'
										,
											(equalityAbstraction = true
												ifTrue: [ '-' ]
												ifFalse: [ '' ]) ]) , fieldType name ])) , ' end'