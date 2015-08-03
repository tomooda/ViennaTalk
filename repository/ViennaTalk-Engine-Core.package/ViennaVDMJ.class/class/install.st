class initialization
install
	self vdmjPath exists
		ifFalse: [ self installVDMJ ].
	self vdmpadPath exists
		ifFalse: [ self installVDMPad ]