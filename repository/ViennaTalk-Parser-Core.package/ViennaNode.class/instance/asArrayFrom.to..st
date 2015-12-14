converting
asArrayFrom: start to: end
	^ (start to: end) collect: [ :i | self at: i ]