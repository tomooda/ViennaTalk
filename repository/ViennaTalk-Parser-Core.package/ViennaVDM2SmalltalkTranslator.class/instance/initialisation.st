parsers-definitions
initialisation
	^ ((self reserved: 'init') , identifier , (self operator: '==') , identifier , eq , 'mk_' asParser , identifier
		, lparen , ((expression separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ])
		, rparen)
		==> [ :array | 
			| patVar patVar2 constructor values |
			patVar := array second.
			patVar2 := array fourth.
			patVar = patVar2
				ifTrue: [ 
					constructor := array seventh.
					values := array ninth.
					{constructor.
					values} ]
				ifFalse: [ PPFailure message: 'init pattern mismatch: ' , patVar , ', ' , patVar2 ] ]