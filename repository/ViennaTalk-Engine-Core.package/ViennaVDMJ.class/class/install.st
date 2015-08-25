class initialization
install
	self vdmjPath exists
		ifFalse: [ self installVDMJ ].
	self json4vdmjPath exists
		ifFalse: [ self installJson4VDMJ ].
	self jsonicPath exists
		ifFalse: [ self installJsonic ]