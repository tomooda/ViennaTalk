Class {
	#name : #ViennaDebugSession,
	#superclass : #DebugSession,
	#category : 'ViennaTalk-Parser-Code Generators'
}

{ #category : #accessing }
ViennaDebugSession >> selectedVDMRangeForContext: selectedContext [
	^ self vdmRangeForContext: selectedContext
]

{ #category : #context }
ViennaDebugSession >> vdmRangeForContext: aContext [
	| smalltalkNode specificationContext vdmNode map currentNode formattedSource |
	specificationContext := aContext specificationContext.
	specificationContext ifNil: [ ^ 1 to: 0 ].
	smalltalkNode := specificationContext method
		sourceNodeForPC: specificationContext neighborPCWithCorrectMapping.
	vdmNode := specificationContext specification.
	map := specificationContext methodClass debuggerNodeMapAt: specificationContext selector.
	currentNode := nil.
	map
		keysAndValuesDo: [ :sNode :vNode | 
			(sNode = smalltalkNode and: [ sNode start = smalltalkNode start ])
				ifTrue: [ currentNode := vNode ] ].
	currentNode ifNil: [ ^ 1 to: 0 ].
	[ formattedSource := ViennaVDMFormatter new format: vdmNode.
	formattedSource asViennaTracingString sources
		do: [ :assoc | 
			assoc value == currentNode
				ifTrue: [ ^ assoc key ] ].
	currentNode isMethod ] whileFalse: [ currentNode := currentNode parent ].
	^ 1 to: 0
]
