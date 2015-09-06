menu
menu
	| menu |
	menu := super menu.
	menu add: 'change interval...' target: self selector: #changeStepTime.
	stepping
		ifTrue: [ menu add: 'stop ticking' target: self selector: #stopStepping ]
		ifFalse: [ menu add: 'start ticking' target: self selector: #startStepping ].
	^ menu