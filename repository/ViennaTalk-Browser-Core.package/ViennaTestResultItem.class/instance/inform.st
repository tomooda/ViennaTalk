notification
inform
	GrowlMorph
		openWithLabel: 'Failed: ' , module , '`' , operation
		contents: (message lines first readStream next: 20)
		color: (Color lightGray mixed: 0.5 with: self class iconColor)