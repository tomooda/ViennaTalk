Extension { #name : #Context }

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Context >> basicSpecification [
	^ self methodClass specificationAt: self selector
]

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Context >> specification [
	^ self specificationContext ifNotNil: #basicSpecification
]

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Context >> specificationContext [
	| context |
	context := self.
	[ ((context receiver isKindOf: ViennaTranspiledObject)
		and: [ context receiver class includesSpecificationFor: context selector ])
		ifTrue: [ ^ context ].
	context := context sender.
	context notNil ] whileTrue.
	^ nil
]
