evaluating
init
	lock
		critical: [ 
			| result postState |
			result := engine evaluate: String new specification: self specification states: Dictionary new.
			result third ifNotEmpty: [ :msg | ^ Error signal: msg ].
			postState := Dictionary new.
			result second
				keysAndValuesDo: [ :module :binds | 
					binds
						keysAndValuesDo: [ :var :value | 
							postState
								at:
									(var = self defaultModule
										ifTrue: [ var ]
										ifFalse: [ module , '`' , var ])
								put: value ] ].
			state := postState ]