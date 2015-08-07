accessing-frames and cuts
removeCutAt: aString
	^ cuts removeKey: aString ifAbsent: [  ]