event handling
handleMouseDown: aMouseEvent
	aMouseEvent wasHandled: true.
	aMouseEvent yellowButtonPressed
		ifTrue: [ 
			(aMouseEvent shiftPressed
				ifTrue: [ self smalltalkMenu ]
				ifFalse: [ self menu ])
				setInvokingView: self;
				invokeModal.
			^ true ].
	self moveable = true
		ifTrue: [ 
			(self edgeName: aMouseEvent position)
				ifNotEmpty: [ :edge | 
					self perform: ('resize' , edge , ':') asSymbol with: aMouseEvent.
					^ true ].
			self currentHand grabMorph: self from: self owner ].
	^ true