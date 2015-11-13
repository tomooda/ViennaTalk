parsers-types
identifiedField
	^ (identifier , (self operator: $:) , type)
		==> [ :triple | 
			Transcript
				cr;
				show: triple printString.
			{(triple first).
			(triple third)} ]