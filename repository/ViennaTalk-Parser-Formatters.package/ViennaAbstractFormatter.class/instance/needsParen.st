private
needsParen
	| childContext childNode childPrecedence parentContext parentNode parentPrecedence |
	childContext := thisContext sender.
	[ childContext notNil and: [ childContext selector ~= #format: ] ] whileTrue: [ childContext := childContext sender ].
	childContext ifNil: [ ^ false ].
	childNode := childContext arguments first.
	childPrecedence := OperatorPrecedence at: childNode label ifAbsent: [ ^ false ].
	parentContext := childContext sender.
	[ parentContext notNil and: [ parentContext selector ~= #format: ] ]
		whileTrue: [ parentContext := parentContext sender ].
	parentContext ifNil: [ ^ false ].
	parentNode := parentContext arguments first.
	parentPrecedence := OperatorPrecedence at: parentNode label ifAbsent: [ ^ false ].
	childPrecedence < parentPrecedence
		ifTrue: [ ^ true ].
	parentPrecedence < childPrecedence
		ifTrue: [ ^ false ].
	^ OperatorGrouping
		at: parentNode label asString
		ifPresent: [ :grouping | 
			(grouping = #left and: [ parentNode first ~= childNode ])
				or: [ grouping = #right and: [ parentNode second ~= childNode ] ] ]
		ifAbsent: [ true ]