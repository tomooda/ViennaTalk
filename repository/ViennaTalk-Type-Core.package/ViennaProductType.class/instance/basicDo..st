enumerating
basicDo: aBlock
	| blockGenerator block |
	blockGenerator := [ :outerCollection :b | [ :v | outerCollection do: [ :outerValue | b value: (v copyWith: outerValue) ] ] ].
	block := blockGenerator value: basetypes last value: aBlock.
	basetypes size - 1 to: 2 by: -1 do: [ :index | block := blockGenerator value: (basetypes at: index) value: block ].
	basetypes first do: [ :v | block value: (Array with: v) ]