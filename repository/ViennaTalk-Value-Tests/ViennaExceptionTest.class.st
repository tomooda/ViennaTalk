Class {
	#name : #ViennaExceptionTest,
	#superclass : #TestCase,
	#category : 'ViennaTalk-Value-Tests'
}

{ #category : #tests }
ViennaExceptionTest >> testTixeIn_noException [
	self
		assert: (ViennaException tixe: {([ :v | true ] -> [ :binds | 2 ])} in: [ 1 ])
		equals: 1
]

{ #category : #tests }
ViennaExceptionTest >> testTixeIn_notTrapped [
	self
		should: [ ViennaException
				tixe: {([ :v | nil ] -> [ :binds | 2 ])}
				in: [ ViennaException expression: 1 ] ]
		raise: ViennaException
]

{ #category : #tests }
ViennaExceptionTest >> testTixeIn_trapped [
	self
		assert:
			(ViennaException
				tixe:
					{([ :v | nil ] -> [ :binds | nil ]).
					([ :v | {('p' -> (v + 2))} asDictionary ]
						-> [ :binds | 
							| p |
							p := binds at: 'p'.
							p + 3 ])}
				in: [ ViennaException expression: 1 ])
		equals: 6
]

{ #category : #tests }
ViennaExceptionTest >> testTixeIn_trapped_then_notTrapped [
	self
		should: [ ViennaException
				tixe:
					{([ :v | nil ] -> [ :binds | nil ]).
					([ :v | 
					v isInteger
						ifTrue: [ Dictionary new ]
						ifFalse: [ nil ] ] -> [ :binds | ViennaException expression: 'fatal' ])}
				in: [ ViennaException expression: 1 ] ]
		raise: ViennaException
]

{ #category : #tests }
ViennaExceptionTest >> testTixeIn_trapped_then_trapped [
	self
		assert:
			(ViennaException
				tixe:
					{([ :v | nil ] -> [ :binds | nil ]).
					([ :v | 
					v isInteger
						ifTrue: [ Dictionary new ]
						ifFalse: [ nil ] ]
						-> [ :binds | ViennaException expression: 'fatal' ]).
					([ :v | 
					v isString
						ifTrue: [ {('p' -> (v , ' handled'))} asDictionary ]
						ifFalse: [ nil ] ]
						-> [ :binds | 
							| p |
							p := binds at: 'p'.
							p , ' and recovered' ])}
				in: [ ViennaException expression: 1 ])
		equals: 'fatal handled and recovered'
]

{ #category : #tests }
ViennaExceptionTest >> testTrapWithIn_noException [
	self
		assert:
			(ViennaException
				trap: [ :v | 
					v
						ifNil: [ nil ]
						ifNotNil: [ Dictionary new
								at: 'p' put: 1;
								yourself ] ]
				with: [ :binds | 
					| p |
					p := binds at: 'p'.
					p + 2 ]
				in: [ 4 ])
		equals: 4
]

{ #category : #tests }
ViennaExceptionTest >> testTrapWithIn_notTrapped [
	self
		should: [ ViennaException
				trap: [ :v | 
					v
						ifNil: [ nil ]
						ifNotNil: [ Dictionary new
								at: 'p' put: 1;
								yourself ] ]
				with: [ :binds | 
					| p |
					p := binds at: 'p'.
					p + 2 ]
				in: [ ViennaException expression: nil ] ]
		raise: ViennaException
]

{ #category : #tests }
ViennaExceptionTest >> testTrapWithIn_trapped [
	self
		assert:
			(ViennaException
				trap: [ :v | 
					v
						ifNil: [ nil ]
						ifNotNil: [ Dictionary new
								at: 'p' put: 1;
								yourself ] ]
				with: [ :binds | 
					| p |
					p := binds at: 'p'.
					p + 2 ]
				in: [ ViennaException expression: 2 ])
		equals: 3
]
