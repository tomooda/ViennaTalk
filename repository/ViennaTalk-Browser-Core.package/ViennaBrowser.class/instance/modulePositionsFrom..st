private
modulePositionsFrom: aString 
	"| modulePositions whiteSpec mark |
	modulePositions := Array new writeStream.
	whiteSpec := (vdmj whiten: aString) readStream.
	mark := nil.
	[| newMark |
	[(whiteSpec skipTo: $m)
		ifFalse: [mark
				ifNil: [modulePositions nextPut: vdmj globalModuleName
							-> (1 to: aString size)]
				ifNotNil: [modulePositions nextPut: mark key
							-> (mark value to: whiteSpec position)].
			^ modulePositions contents].
	(whiteSpec next: 'odule' size)
		= 'odule'] whileFalse.
	newMark := whiteSpec position - 'module' size + 1.
	mark
		ifNotNil: [modulePositions nextPut: mark key
					-> (mark value to: newMark - 1)].
	whiteSpec skipSeparators.
	String new writeStream
		in: [:name | 
			[whiteSpec atEnd not
				and: [whiteSpec peek isSeparator not]]
				whileTrue: [name nextPut: whiteSpec next].
			mark := name contents -> newMark]] repeat"