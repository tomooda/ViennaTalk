code generation-expressions
casesExpressionAlternatives: aViennaNode
	^ aViennaNode collect: [ :node | self generate: node ]