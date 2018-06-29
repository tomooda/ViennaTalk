Extension { #name : #Context }

{ #category : #'*ViennaTalk-Transpiler-Debugger' }
Context >> basicSpecification [
	^ self methodClass specificationAt: self selector
]

{ #category : #'*ViennaTalk-Transpiler-Debugger' }
Context >> specification [
	^ self specificationContext ifNotNil: #basicSpecification
]

{ #category : #'*ViennaTalk-Transpiler-Debugger' }
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
