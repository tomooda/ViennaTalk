parsers-types
identifiedField
	^ (identifier , colon , type)
		==> [ :triple | 
			Transcript
				cr;
				show: triple printString.
			{(triple first).
			(triple third)} ]