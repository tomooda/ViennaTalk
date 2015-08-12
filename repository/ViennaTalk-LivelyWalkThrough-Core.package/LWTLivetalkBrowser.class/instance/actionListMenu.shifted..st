action list menu
actionListMenu: aMenu shifted: shifted 
	"Answer the message-list menu"
	shifted
		ifTrue: [^ self shiftedActionListMenu: aMenu].
	aMenu addList: #(
		#('do it (d)' #doIt )
		-
		#('remove (x)' #removeAction )
	).
	^ aMenu