parsers
vdmValue
	^ ViennaVDMValueDecoder new expression ==> [ :obj | WWTTranslationObjectMatcher with: obj ]