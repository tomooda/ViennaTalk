"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestViennaTalkParserCore',
	#superclass : 'PackageManifest',
	#category : 'ViennaTalk-Parser-Core',
	#package : 'ViennaTalk-Parser-Core'
}

{ #category : 'code-critics' }
ManifestViennaTalkParserCore class >> ruleRBMethodHasNoTimeStampRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'ViennaTalk-Parser-Core')) #'2018-11-29T13:17:03.191817+09:00') )
]
