randomization
shuffleDo: anArrayOfBlock
	(anArrayOfBlock collect: [ :block | self random next -> block ]) asSortedCollection do: [ :assoc | assoc value value ]