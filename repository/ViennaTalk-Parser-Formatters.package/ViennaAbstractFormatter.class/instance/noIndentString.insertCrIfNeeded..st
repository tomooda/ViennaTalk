private
noIndentString: aString insertCrIfNeeded: anotherString
	^ anotherString
		ifEmpty: [ aString ]
		ifNotEmpty: [ 
			aString
				,
					((self needsIndent: aString , anotherString)
						ifTrue: [ String cr ]
						ifFalse: [ String space ]) , anotherString ]