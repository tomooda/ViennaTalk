context
vdmPcNodeForContext: aContext
	| smalltalkNode specificationContext vdmNode map currentNode |
	specificationContext := aContext specificationContext.
	specificationContext ifNil: [ ^ nil ].
	smalltalkNode := specificationContext method
		sourceNodeForPC: specificationContext neighborPCWithCorrectMapping.
	vdmNode := specificationContext specification.
	map := specificationContext methodClass debuggerNodeMapAt: specificationContext selector.
	currentNode := nil.
	map
		keysAndValuesDo: [ :sNode :vNode | 
			(sNode = smalltalkNode and: [ sNode start = smalltalkNode start ])
				ifTrue: [ currentNode := vNode ] ].
	^ currentNode