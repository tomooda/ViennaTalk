parsers
rule
	^ (vdmPattern , '<=>' asParser trim , jsonPattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]