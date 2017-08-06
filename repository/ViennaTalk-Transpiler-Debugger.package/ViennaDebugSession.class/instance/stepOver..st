debugging actions
stepOver: aContext
	"Send the selected message in selectedContext, and regain control 
	after the invoked method returns."

	| newContext specificationContext node newNode |
	(self isContextPostMortem: aContext)
		ifTrue: [ ^ self ].
	aContext isDead
		ifTrue: [ ^ self ].
	specificationContext := aContext specificationContext.
	specificationContext ifNil: [ ^ super stepOver: aContext ].
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