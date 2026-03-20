Extension { #name : 'Context' }

{ #category : '*ViennaTalk-Transpiler-Debugger' }
Context >> basicSpecification [
	^ self methodClass specificationAt: self selector
]

{ #category : '*ViennaTalk-Transpiler-Debugger' }
Context >> specification [
	^ self specificationContext ifNotNil: #basicSpecification
]

{ #category : '*ViennaTalk-Transpiler-Debugger' }
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

{ #category : '*ViennaTalk-Transpiler-Debugger' }
Context >> vdmPcNode [

	| smalltalkNode vdmNode map currentNode |
	smalltalkNode := self method sourceNodeForPC: pc.
	vdmNode := self specification.
	map := self methodClass debuggerNodeMapAt: self selector.
	currentNode := nil.
	map keysAndValuesDo: [ :sNode :vNode |
			(sNode = smalltalkNode and: [ sNode start = smalltalkNode start ])
				ifTrue: [ currentNode := vNode ] ].
	^ currentNode
]

{ #category : '*ViennaTalk-Transpiler-Debugger' }
Context >> vdmPcNodes [

	| nodes context |
	nodes := OrderedCollection new.
	context := self specificationContext.
	[ context notNil ] whileTrue: [
			nodes addLast: context vdmPcNode.
			context := context sender specificationContext ].
	^ nodes asArray
]
