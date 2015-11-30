accessing
name
	^ ('*'
		join:
			(argtypes
				collect: [ :t | 
					t
						nameInPrecedence:
							(argtypes size = 1
								ifTrue: [ self class precedence + 1 ]
								ifFalse: [ ViennaProductType precedence ]) ])) , '+>' , (returntype nameInPrecedence: self class precedence)