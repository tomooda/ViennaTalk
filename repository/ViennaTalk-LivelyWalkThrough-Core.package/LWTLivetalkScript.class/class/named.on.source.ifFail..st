instance creation
named: aString on: performer source: source ifFail: errorBlock
	| nameString widgetName event |
	nameString := aString trimmed.
	(nameString findLastOccurrenceOfString: '`' startingAt: 1)
		in: [ :index | 
			index = 0
				ifTrue: [ ^ errorBlock cull: 'Invalid name: name should be in the form of widgetName`event.' ].
			widgetName := nameString copyFrom: 1 to: index - 1.
			event := nameString copyFrom: index + 1 to: nameString size ].
	^ self new
		setWidgetName: widgetName
			event: event
			performer: performer
			source: source
			ifFail: errorBlock;
		yourself