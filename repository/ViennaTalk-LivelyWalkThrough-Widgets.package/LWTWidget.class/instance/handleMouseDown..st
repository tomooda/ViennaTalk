event handling
handleMouseDown: aMouseEvent
	aMouseEvent yellowButtonPressed
		ifTrue: [ 
			self menu
				setInvokingView: self;
				invokeModal.
			aMouseEvent wasHandled: true.
			^ true ].
	(self edgeName: aMouseEvent position)
		ifNotEmpty: [ :edge | self perform: ('resize' , edge , ':') asSymbol with: aMouseEvent ].
	^ super handleMouseDown: aMouseEvent