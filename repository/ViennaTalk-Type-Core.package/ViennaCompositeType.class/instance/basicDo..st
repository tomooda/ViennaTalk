enumerating
basicDo: aBlock
	| blockGenerator block |
	blockGenerator := [ :outerCollection :b | [ :v | outerCollection do: [ :outerValue | b value: (v copyWith: outerValue) ] ] ].
	block := blockGenerator value: (self basetypeAt: self size) value: aBlock.
	self size - 1 to: 2 by: -1 do: [ :index | block := blockGenerator value: (self basetypeAt: index) value: block ].
	(self basetypeAt: 1) do: [ :v | block value: (Array with: v) ]