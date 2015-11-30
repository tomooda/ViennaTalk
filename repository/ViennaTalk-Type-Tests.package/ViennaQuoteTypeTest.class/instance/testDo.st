tests
testDo
	self assert: (Array new: 1 streamContents: [ :stream | quote do: [ :v | stream nextPut: v ] ]) equals: #(#'<QUOTE>')