event handling
handleMouseDown: aMouseEvent
	aMouseEvent yellowButtonPressed
		ifFalse: [ 
			stepping
				ifTrue: [ self stepping: false ].
			self step ].
	^ super handleMouseDown: aMouseEvent