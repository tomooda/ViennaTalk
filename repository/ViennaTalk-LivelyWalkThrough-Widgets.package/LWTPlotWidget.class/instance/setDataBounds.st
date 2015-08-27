operations
setDataBounds
	(UIManager default
		request: 'data bounds (min x, min y, max x, max y)'
		initialAnswer:
			(dataBounds
				ifNotNil: [ 
					dataBounds left printString , ', ' , dataBounds top printString , ', ' , dataBounds right printString , ', '
						, dataBounds bottom printString ]
				ifNil: [ '-1, -1, 1, 1' ])
		title: self name)
		ifNotNil: [ :quad | 
			[ 
			| stream reader left top right bottom |
			stream := quad trim readStream.
			reader := ViennaReader new.
			left := reader parseNumberOn: stream.
			stream skipSeparators.
			stream next = $,
				ifFalse: [ self error: 'wrong format' ].
			stream skipSeparators.
			top := reader parseNumberOn: stream.
			stream skipSeparators.
			stream next = $,
				ifFalse: [ self error: 'wrong format' ].
			stream skipSeparators.
			right := reader parseNumberOn: stream.
			stream skipSeparators.
			stream next = $,
				ifFalse: [ self error: 'wrong format' ].
			stream skipSeparators.
			bottom := reader parseNumberOn: stream.
			dataBounds := left @ top corner: right @ bottom.
			self changed.
			^ true ]
				on: Error
				do: [ :ex | ^ false ] ]