debugging actions
vdmStepInto: aContext
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