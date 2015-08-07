accessing-frames and cuts
cutAt: aString
	^ aString
		ifNotNil: [ 
			cuts
				at: aString
				ifAbsentPut: [ 
					LWTCut new
						addFrames: frames contents;
						yourself ] ]