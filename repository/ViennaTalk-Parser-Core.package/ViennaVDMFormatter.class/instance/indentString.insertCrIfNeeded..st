private
indentString: aString insertCrIfNeeded: anotherString
	^ anotherString
		ifEmpty: [ aString ]
		ifNotEmpty: [ 
			self
				indentString:
					aString
						,
							((self needsIndent: aString , anotherString)
								ifTrue: [ String cr ]
								ifFalse: [ String space ]) , anotherString ]