drawing
drawHighlightedOn: aCanvas
	self director
		ifNotNil: [ :d | 
			d
				selectedWidgetsDo: [ :morph | 
					self == morph
						ifTrue: [ aCanvas frameRectangle: (self bounds insetBy: -1) width: 3 color: Color blue ] ] ]