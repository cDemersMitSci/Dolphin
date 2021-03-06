"Filed out from Dolphin Smalltalk 7"!

ENHMETARECORD subclass: #EMRTRANSPARENTBLT
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EMRTRANSPARENTBLT guid: (GUID fromString: '{e45acb58-6465-4c29-84da-a3b8e0b9b384}')!
EMRTRANSPARENTBLT comment: '<EMRTRANSPARENTBLT> is an <ExternalStructure> class to wrap the struct ''Win32.EMRTRANSPARENTBLT'' from type information in the ''Win32 API (ANSI). Derived from Bruce McKinney�s Hardcore Visual Basic Type Library'' library.

The type library contains no documentation for this struct

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef [uuid(E45ACB58-6465-4C29-84DA-A3B8E0B9B384)]
struct tagEMRTRANSPARENTBLT {
	EMR EMR;
	[helpstring("Inclusive-inclusive bounds in device units")] RECTL rclBounds;
	long xDest;
	long yDest;
	long cxDest;
	long cyDest;
	DWORD dwRop;
	long xSrc;
	long ySrc;
	[helpstring("Source DC transform")] XFORM xformSrc;
	[helpstring("Source DC BkColor in RGB")] COLORREF crBkColorSrc;
	[helpstring("Source bitmap info color table usage (DIB_RGB_COLORS)")] DWORD iUsageSrc;
	[helpstring("Offset to the source BITMAPINFO structure")] DWORD offBmiSrc;
	[helpstring("Size of the source BITMAPINFO structure")] DWORD cbBmiSrc;
	[helpstring("Offset to the source bitmap bits")] DWORD offBitsSrc;
	[helpstring("Size of the source bitmap bits")] DWORD cbBitsSrc;
	long cxSrc;
	long cySrc;
} EMRTRANSPARENTBLT;
'!
!EMRTRANSPARENTBLT categoriesForClass!Win32-Structs! !
!EMRTRANSPARENTBLT methodsFor!

cbBitsSrc
	"Answer the receiver's cbBitsSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #cbBitsSrc)!

cbBitsSrc: anObject 
	"Set the receiver's cbBitsSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #cbBitsSrc) put: anObject!

cbBmiSrc
	"Answer the receiver's cbBmiSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #cbBmiSrc)!

cbBmiSrc: anObject 
	"Set the receiver's cbBmiSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #cbBmiSrc) put: anObject!

crBkColorSrc
	"Answer the receiver's crBkColorSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #crBkColorSrc)!

crBkColorSrc: anObject 
	"Set the receiver's crBkColorSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #crBkColorSrc) put: anObject!

cxDest
	"Answer the receiver's cxDest field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #cxDest)!

cxDest: anObject 
	"Set the receiver's cxDest field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #cxDest) put: anObject!

cxSrc
	"Answer the receiver's cxSrc field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #cxSrc)!

cxSrc: anObject 
	"Set the receiver's cxSrc field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #cxSrc) put: anObject!

cyDest
	"Answer the receiver's cyDest field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #cyDest)!

cyDest: anObject 
	"Set the receiver's cyDest field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #cyDest) put: anObject!

cySrc
	"Answer the receiver's cySrc field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #cySrc)!

cySrc: anObject 
	"Set the receiver's cySrc field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #cySrc) put: anObject!

dwRop
	"Answer the receiver's dwRop field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #dwRop)!

dwRop: anObject 
	"Set the receiver's dwRop field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #dwRop) put: anObject!

iUsageSrc
	"Answer the receiver's iUsageSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #iUsageSrc)!

iUsageSrc: anObject 
	"Set the receiver's iUsageSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #iUsageSrc) put: anObject!

offBitsSrc
	"Answer the receiver's offBitsSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #offBitsSrc)!

offBitsSrc: anObject 
	"Set the receiver's offBitsSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #offBitsSrc) put: anObject!

offBmiSrc
	"Answer the receiver's offBmiSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #offBmiSrc)!

offBmiSrc: anObject 
	"Set the receiver's offBmiSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #offBmiSrc) put: anObject!

rclBounds
	"Answer the receiver's rclBounds field as a Smalltalk object."

	^RECT fromAddress: bytes yourAddress + ##(self offsetOf: #rclBounds)!

rclBounds: anObject 
	"Set the receiver's rclBounds field to the value of anObject."

	anObject 
		replaceBytesOf: bytes
		from: ##((self offsetOf: #rclBounds) + 1)
		to: ##((self offsetOf: #rclBounds) + RECT basicByteSize)
		startingAt: 1!

xDest
	"Answer the receiver's xDest field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #xDest)!

xDest: anObject 
	"Set the receiver's xDest field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #xDest) put: anObject!

xformSrc
	"Answer the receiver's xformSrc field as a Smalltalk object."

	^XFORM fromAddress: bytes yourAddress + ##(self offsetOf: #xformSrc)!

xformSrc: anObject 
	"Set the receiver's xformSrc field to the value of anObject."

	anObject 
		replaceBytesOf: bytes
		from: ##((self offsetOf: #xformSrc) + 1)
		to: ##((self offsetOf: #xformSrc) + XFORM basicByteSize)
		startingAt: 1!

xSrc
	"Answer the receiver's xSrc field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #xSrc)!

xSrc: anObject 
	"Set the receiver's xSrc field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #xSrc) put: anObject!

yDest
	"Answer the receiver's yDest field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #yDest)!

yDest: anObject 
	"Set the receiver's yDest field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #yDest) put: anObject!

ySrc
	"Answer the receiver's ySrc field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #ySrc)!

ySrc: anObject 
	"Set the receiver's ySrc field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #ySrc) put: anObject! !
!EMRTRANSPARENTBLT categoriesFor: #cbBitsSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cbBitsSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cbBmiSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cbBmiSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #crBkColorSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #crBkColorSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cxDest!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cxDest:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cxSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cxSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cyDest!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cyDest:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cySrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #cySrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #dwRop!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #dwRop:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #iUsageSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #iUsageSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #offBitsSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #offBitsSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #offBmiSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #offBmiSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #rclBounds!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #rclBounds:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #xDest!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #xDest:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #xformSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #xformSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #xSrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #xSrc:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #yDest!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #yDest:!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #ySrc!**compiled accessors**!public! !
!EMRTRANSPARENTBLT categoriesFor: #ySrc:!**compiled accessors**!public! !

!EMRTRANSPARENTBLT class methodsFor!

defineFields
	"Define the fields of the EMRTRANSPARENTBLT structure.

	EMRTRANSPARENTBLT  compileDefinition

		typedef [uuid(E45ACB58-6465-4C29-84DA-A3B8E0B9B384)]
		struct tagEMRTRANSPARENTBLT {
			EMR EMR;
			[helpstring('Inclusive-inclusive bounds in device units')] RECTL rclBounds;
			long xDest;
			long yDest;
			long cxDest;
			long cyDest;
			DWORD dwRop;
			long xSrc;
			long ySrc;
			[helpstring('Source DC transform')] XFORM xformSrc;
			[helpstring('Source DC BkColor in RGB')] COLORREF crBkColorSrc;
			[helpstring('Source bitmap info color table usage (DIB_RGB_COLORS)')] DWORD iUsageSrc;
			[helpstring('Offset to the source BITMAPINFO structure')] DWORD offBmiSrc;
			[helpstring('Size of the source BITMAPINFO structure')] DWORD cbBmiSrc;
			[helpstring('Offset to the source bitmap bits')] DWORD offBitsSrc;
			[helpstring('Size of the source bitmap bits')] DWORD cbBitsSrc;
			long cxSrc;
			long cySrc;
		} EMRTRANSPARENTBLT;
"

	super defineFields.
	self
		defineField: #rclBounds
			type: (StructureField type: RECT)
			offset: 8;
		defineField: #xDest
			type: SDWORDField new
			offset: 24;
		defineField: #yDest
			type: SDWORDField new
			offset: 28;
		defineField: #cxDest
			type: SDWORDField new
			offset: 32;
		defineField: #cyDest
			type: SDWORDField new
			offset: 36;
		defineField: #dwRop
			type: DWORDField new
			offset: 40;
		defineField: #xSrc
			type: SDWORDField new
			offset: 44;
		defineField: #ySrc
			type: SDWORDField new
			offset: 48;
		defineField: #xformSrc
			type: (StructureField type: XFORM)
			offset: 52;
		defineField: #crBkColorSrc
			type: DWORDField new
			offset: 76;
		defineField: #iUsageSrc
			type: DWORDField new
			offset: 80;
		defineField: #offBmiSrc
			type: DWORDField new
			offset: 84;
		defineField: #cbBmiSrc
			type: DWORDField new
			offset: 88;
		defineField: #offBitsSrc
			type: DWORDField new
			offset: 92;
		defineField: #cbBitsSrc
			type: DWORDField new
			offset: 96;
		defineField: #cxSrc
			type: SDWORDField new
			offset: 100;
		defineField: #cySrc
			type: SDWORDField new
			offset: 104.
	self byteSize: 108!

iTypes
	"Answer the integer enhanced metafile record type id for this record class."

	^Array with: EMR_TRANSPARENTBLT! !
!EMRTRANSPARENTBLT class categoriesFor: #defineFields!**auto generated**!initializing!public! !
!EMRTRANSPARENTBLT class categoriesFor: #iTypes!constants!public! !

