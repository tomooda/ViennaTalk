streaming
nextPutAll: aString
	aString isViennaTracingString
		ifTrue: [ | size |
			size := string size.
			sources addAll: (aString sources collect: [ :assoc | assoc key + size -> assoc value ]).
			string := string , aString string ]
		ifFalse: [ string := string , aString ]