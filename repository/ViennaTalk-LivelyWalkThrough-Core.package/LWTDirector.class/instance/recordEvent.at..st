accessing-frames and cuts
recordEvent: aSymbol at: aMorph
	self addFrame: (LWTEventFrame morphName: aMorph name event: aSymbol)