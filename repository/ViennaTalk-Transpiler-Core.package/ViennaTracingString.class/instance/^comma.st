copying
, aString
	^ aString isViennaTracingString
		ifTrue: [ | size newSources |
			size := string size.
			newSources := OrderedCollection new: sources size + aString sources size.
			newSources addAll: sources.
			aString sources do: [ :assoc | newSources add: assoc key + size -> assoc value ].
			self class string: string , aString string sources: newSources ]
		ifFalse: [ self class string: string , aString sources: sources copy]