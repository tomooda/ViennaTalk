accessing-frames and cuts
cutAt: aString put: anLWTCut
	^ aString ifNotNil: [ anLWTCut ifNotNil: [ cuts at: aString put: anLWTCut ] ]