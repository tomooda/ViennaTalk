code generation
generateAll: aViennaNode env: aDictionary
	^ aViennaNode collect: [ :node | self generate: node env: aDictionary ]