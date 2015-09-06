private
classicChanged: aSymbol
	self dependents do: [ :aDependent | aDependent update: aSymbol ]