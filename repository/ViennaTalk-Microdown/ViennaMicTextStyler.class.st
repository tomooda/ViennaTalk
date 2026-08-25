Class {
	#name : 'ViennaMicTextStyler',
	#superclass : 'MicTextStyler',
	#category : 'ViennaTalk-Microdown-Microdown',
	#package : 'ViennaTalk-Microdown',
	#tag : 'Microdown'
}

{ #category : 'private' }
ViennaMicTextStyler >> computeHeaderFonts [

	headerFonts := Array new: self headerFontSizes size.
	1 to: headerFonts size do: [ :index |
			headerFonts
				at: index
				put:
				(TextFontReference toFont:
					 (LogicalFont familyName: ViennaLauncher font familyName pointSize: (self headerFontSizes at: index))) ]
]
