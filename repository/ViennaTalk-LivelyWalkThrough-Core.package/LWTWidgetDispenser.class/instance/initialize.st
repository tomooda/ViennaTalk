initialize-release
initialize
	super initialize.
	self color: Color white.
	self
		changeTableLayout;
		listDirection: #topToBottom.
	self addMorph: self fieldWidget.
	self addMorph: self buttonWidget.
	self addMorph: self padWidget.
	self addMorph: self areaWidget