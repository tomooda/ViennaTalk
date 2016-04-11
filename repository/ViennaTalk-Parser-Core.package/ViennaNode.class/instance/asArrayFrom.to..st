converting
asArrayFrom: anInteger1 to: anInteger2
	^ (anInteger1 to: anInteger2) collect: [ :i | self at: i ]