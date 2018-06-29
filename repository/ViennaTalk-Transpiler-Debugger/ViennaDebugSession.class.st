Class {
	#name : #ViennaDebugSession,
	#superclass : #DebugSession,
	#category : 'ViennaTalk-Transpiler-Debugger'
}

{ #category : #accessing }
ViennaDebugSession >> selectedVDMRangeForContext: selectedContext [
	^ self vdmRangeForContext: selectedContext
]

{ #category : #context }
ViennaDebugSession >> vdmPcNodeForContext: aContext [
	| smalltalkNode specificationContext vdmNode map currentNode |
	specificationContext := aContext specificationContext.
	specificationContext ifNil: [ ^ nil ].
	smalltalkNode := specificationContext method
		sourceNodeForPC:
			(specificationContext neighborPCWithCorrectMapping
				in: [ :pc | 
					(self isLatestContext: aContext)
						ifTrue: [ pc ]
						ifFalse: [ pc - 1 ] ]).
	vdmNode := specificationContext specification.
	map := specificationContext methodClass debuggerNodeMapAt: specificationContext selector.
	currentNode := nil.
	map
		keysAndValuesDo: [ :sNode :vNode | 
			(sNode = smalltalkNode and: [ sNode start = smalltalkNode start ])
				ifTrue: [ currentNode := vNode ] ].
	^ currentNode
]

{ #category : #context }
ViennaDebugSession >> vdmRangeForContext: aContext [
	| currentNode formattedSource |
	currentNode := self vdmPcNodeForContext: aContext.
	currentNode ifNil: [ ^ 1 to: 0 ].
	[ formattedSource := ViennaVDMTracingFormatter new
		format: aContext specificationContext specification.
	formattedSource asViennaTracingString sources
		do: [ :assoc | 
			assoc value == currentNode
				ifTrue: [ ^ assoc key ] ].
	currentNode := currentNode parent.
	currentNode notNil ] whileTrue.
	^ 1 to: 0
]

{ #category : #'debugging actions' }
ViennaDebugSession >> vdmStepInto: aContext [
	"Send the selected message in selectedContext, and take control in 
	the method invoked to allow further step or send."

	| specificationContext node newContext newNode |
	(self isContextPostMortem: aContext)
		ifTrue: [ ^ self ].
	aContext isDead
		ifTrue: [ ^ self ].
	specificationContext := aContext specificationContext.
	specificationContext ifNil: [ ^ self ].
	node := self vdmPcNodeForContext: aContext.
	[ interruptedProcess step.
	newContext := self stepToFirstInterestingBytecodeIn: interruptedProcess.
	newNode := self vdmPcNodeForContext: newContext.
	(self isContextPostMortem: aContext)
		or: [ newNode notNil
				and: [ newContext specificationContext ~~ specificationContext or: [ newNode ~~ node ] ] ] ]
		whileFalse: [ self updateContextTo: newContext.
			self triggerEvent: #stepInto ].
	self updateContextTo: newContext.
	self triggerEvent: #stepInto
]

{ #category : #'debugging actions' }
ViennaDebugSession >> vdmStepOver: aContext [
	"Send the selected message in selectedContext, and regain control 
	after the invoked method returns."

	| newContext specificationContext node newNode |
	(self isContextPostMortem: aContext)
		ifTrue: [ ^ self ].
	aContext isDead
		ifTrue: [ ^ self ].
	specificationContext := aContext specificationContext.
	specificationContext ifNil: [ ^ self ].
	node := self vdmPcNodeForContext: aContext.
	[ newContext := interruptedProcess completeStep: aContext.
	newContext == aContext
		ifTrue: [ newContext := self stepToFirstInterestingBytecodeIn: interruptedProcess ].
	newNode := self vdmPcNodeForContext: newContext.
	(self isContextPostMortem: aContext)
		or: [ newNode notNil
				and: [ newContext specificationContext ~~ specificationContext or: [ newNode ~~ node ] ] ] ]
		whileFalse: [ self updateContextTo: newContext.
			self triggerEvent: #stepOver ].
	self updateContextTo: newContext.
	self triggerEvent: #stepOver
]
