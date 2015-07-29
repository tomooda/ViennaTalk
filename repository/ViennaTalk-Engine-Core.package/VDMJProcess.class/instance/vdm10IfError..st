commands
vdm10IfError: errorBlock 
	^ self
		send: 'vdm10'
		responseDo: [:unit | unit]
		ifError: errorBlock