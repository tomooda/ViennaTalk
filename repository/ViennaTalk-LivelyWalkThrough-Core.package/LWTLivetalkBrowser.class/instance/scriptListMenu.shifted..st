script list menu
scriptListMenu: aMenu shifted: shifted 
	"Answer the message-list menu"
	shifted
		ifTrue: [^ self shiftedScriptListMenu: aMenu].
	aMenu addList: #(
		#('do it (d)' #doIt )
		-
		#('remove (x)' #removeScript )
	).
	^ aMenu