"Filed out from Dolphin Smalltalk 7"!

EMREXTTEXTOUT subclass: #EMREXTTEXTOUTA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EMREXTTEXTOUTA guid: (GUID fromString: '{897dbf3a-44ad-4594-ae7e-957cb1e28374}')!
EMREXTTEXTOUTA comment: '<EMREXTTEXTOUTA> is an <ExternalStructure> class to wrap the struct ''Win32.EMREXTTEXTOUTA'' from type information in the ''Win32 API (ANSI). Derived from Bruce McKinney�s Hardcore Visual Basic Type Library'' library.

The type library contains no documentation for this struct

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef [uuid(897DBF3A-44AD-4594-AE7E-957CB1E28374)]
struct tagEMREXTTEXTOUTA {
	EMR EMR;
	[helpstring("Inclusive-inclusive bounds in device units")] RECTL rclBounds;
	[helpstring("Current graphics mode")] DWORD iGraphicsMode;
	[helpstring("X and Y scales from Page units to .01mm units")] float exScale;
	[helpstring("if graphics mode is GM_COMPATIBLE.")] float eyScale;
	[helpstring("This is followed by the string and spacing array")] EMRTEXT EMRTEXT;
} EMREXTTEXTOUTA;
'!
!EMREXTTEXTOUTA categoriesForClass!Win32-Structs! !
!EMREXTTEXTOUTA methodsFor!

text
	"Answer the receiver's text field as a Smalltalk object."

	^String fromAddress: bytes yourAddress + ##(self offsetOf: #text) length: self EMRTEXT nChars!

text: anObject 
	"Set the receiver's text field to the value of anObject."

	| size |
	size := anObject byteSize - 1 min: self EMRTEXT nChars.
	anObject 
		replaceBytesOf: bytes
		from: ##((self offsetOf: #text) + 1)
		to: ##(self offsetOf: #text) + size
		startingAt: 1.
	bytes byteAtOffset: ##(self offsetOf: #text) + size put: 0! !
!EMREXTTEXTOUTA categoriesFor: #text!public! !
!EMREXTTEXTOUTA categoriesFor: #text:!public! !

!EMREXTTEXTOUTA class methodsFor!

defineFields
	"Define the fields of the EMREXTTEXTOUTA structure.

	EMREXTTEXTOUTA  compileDefinition
	"

	super defineFields.
	self defineField: #text type: (StringField type: String length: 1)!

iTypes
	"Answer the integer enhanced metafile record type id for this record class."

	^Array with: EMR_EXTTEXTOUTA! !
!EMREXTTEXTOUTA class categoriesFor: #defineFields!initializing!public! !
!EMREXTTEXTOUTA class categoriesFor: #iTypes!constants!public! !

