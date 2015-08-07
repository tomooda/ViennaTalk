accessing-frames and cuts
cutAt: aString ifAbsent: errorBlock
	^ aString ifNotNil: [ cuts at: aString ifAbsent: errorBlock ]