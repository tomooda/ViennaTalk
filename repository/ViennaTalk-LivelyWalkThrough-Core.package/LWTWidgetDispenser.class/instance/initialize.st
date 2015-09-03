initialize-release
initialize
	super initialize.
	self color: Color white.
	self
		changeTableLayout;
		listDirection: #topToBottom;
		cellInset: 3.
	self addMorphBack: self fieldWidget.
	self addMorphBack: self plotWidget.
	self addMorphBack: self imageWidget.
	self addMorphBack: self buttonWidget.
	self addMorphBack: self padWidget.
	self addMorphBack: self areaWidget.
	self addMorphBack: self remoteWidget