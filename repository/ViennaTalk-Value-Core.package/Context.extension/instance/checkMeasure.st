*ViennaTalk-Value-Core
checkMeasure
	| context |
	context := self sender.
	[ context notNil ]
		whileTrue: [ 
			self closure == context closure
				ifTrue: [ 
					| scope var m1 m2 |
					scope := self sourceNode scope.
					(scope allTempNames includes: 'measure')
						ifFalse: [ ^ true ].
					var := scope lookupVar: 'measure'.
					m1 := (var searchFromContext: context scope: scope).
					m2 := (var searchFromContext: self scope: scope).
					^ m1 > m2
					 ].
			context := context sender ].
	^ true