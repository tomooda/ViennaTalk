Extension { #name : #Context }

{ #category : #'*ViennaTalk-Value-Core' }
Context >> checkMeasure [
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
					m1 := (var readFromContext: context scope: scope).
					m2 := (var readFromContext: self scope: scope).
					^ m1 > m2
					 ].
			context := context sender ].
	^ true
]

{ #category : #'*ViennaTalk-Value-Core' }
Context >> viennaReturn: anObject [
	| scope |
	scope := self sourceNode scope.
	(scope allTempNames includes: '_opContext')
		ifFalse: [ ^ self return: anObject ].
	"(self tempNamed: '_opContext') return: anObject"
	^ ((scope lookupVar: '_opContext') readFromContext: self scope: scope) return: anObject
]
