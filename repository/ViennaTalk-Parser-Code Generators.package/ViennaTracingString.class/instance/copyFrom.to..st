copying
copyFrom: start to: end
	| newSources |
	newSources := OrderedCollection new: sources size.
	sources
		do: [ :assoc | 
			| newStart newEnd |
			newStart := start max: assoc key first.
			newEnd := end min: assoc key last.
			newStart <= newEnd
				ifTrue: [ newSources add: (newStart - start + 1 to: newEnd - start + 1) -> assoc value ] ].
	^ self class string: (string copyFrom: start to: end) sources: newSources