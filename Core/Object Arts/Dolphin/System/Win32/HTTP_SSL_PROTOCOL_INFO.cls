"Filed out from Dolphin Smalltalk 7"!

HttpServerStructure subclass: #HTTP_SSL_PROTOCOL_INFO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
HTTP_SSL_PROTOCOL_INFO guid: (GUID fromString: '{73784afd-f4e5-464e-b716-46ebb0c8c6d1}')!
HTTP_SSL_PROTOCOL_INFO comment: '<HTTP_SSL_PROTOCOL_INFO> is an <ExternalStructure> class to wrap the struct ''WinHttpServer.HTTP_SSL_PROTOCOL_INFO'' from type information in the ''Windows Http Server API'' library.

The type library contains the following helpstring for this struct
	"HttpRequestInfoTypeSslProtocol payload. Contains basic information about the SSL/TLS protocol and cipher. See SecPkgContext_ConnectionInfo documentation for details."

** This comment was automatically generated from a type library. Delete this line to prevent any manual edits from being overwritten if the wrapper class is regenerated. **

IDL definition follows:

typedef [uuid(73784afd-f4e5-464e-b716-46ebb0c8c6d1), helpstring("HttpRequestInfoTypeSslProtocol payload. Contains basic information about the SSL/TLS protocol and cipher. See SecPkgContext_ConnectionInfo documentation for details.")]
struct tagHTTP_SSL_PROTOCOL_INFO {
	[readonly] ULONG Protocol;
	[readonly] ULONG CipherType;
	[readonly] ULONG CipherStrength;
	[readonly] ULONG HashType;
	[readonly] ULONG HashStrength;
	[readonly] ULONG KeyExchangeType;
	[readonly] ULONG KeyExchangeStrength;
} HTTP_SSL_PROTOCOL_INFO;
'!
!HTTP_SSL_PROTOCOL_INFO categoriesForClass!WinHttpServer-Structs! !
!HTTP_SSL_PROTOCOL_INFO methodsFor!

CipherStrength
	"Answer the <Integer> value of the receiver's 'CipherStrength' field."

	^bytes dwordAtOffset: ##(self offsetOf: #CipherStrength)!

CipherType
	"Answer the <Integer> value of the receiver's 'CipherType' field."

	^bytes dwordAtOffset: ##(self offsetOf: #CipherType)!

HashStrength
	"Answer the <Integer> value of the receiver's 'HashStrength' field."

	^bytes dwordAtOffset: ##(self offsetOf: #HashStrength)!

HashType
	"Answer the <Integer> value of the receiver's 'HashType' field."

	^bytes dwordAtOffset: ##(self offsetOf: #HashType)!

KeyExchangeStrength
	"Answer the <Integer> value of the receiver's 'KeyExchangeStrength' field."

	^bytes dwordAtOffset: ##(self offsetOf: #KeyExchangeStrength)!

KeyExchangeType
	"Answer the <Integer> value of the receiver's 'KeyExchangeType' field."

	^bytes dwordAtOffset: ##(self offsetOf: #KeyExchangeType)!

Protocol
	"Answer the <Integer> value of the receiver's 'Protocol' field."

	^bytes dwordAtOffset: 0! !
!HTTP_SSL_PROTOCOL_INFO categoriesFor: #CipherStrength!**compiled accessors**!public! !
!HTTP_SSL_PROTOCOL_INFO categoriesFor: #CipherType!**compiled accessors**!public! !
!HTTP_SSL_PROTOCOL_INFO categoriesFor: #HashStrength!**compiled accessors**!public! !
!HTTP_SSL_PROTOCOL_INFO categoriesFor: #HashType!**compiled accessors**!public! !
!HTTP_SSL_PROTOCOL_INFO categoriesFor: #KeyExchangeStrength!**compiled accessors**!public! !
!HTTP_SSL_PROTOCOL_INFO categoriesFor: #KeyExchangeType!**compiled accessors**!public! !
!HTTP_SSL_PROTOCOL_INFO categoriesFor: #Protocol!**compiled accessors**!public! !

!HTTP_SSL_PROTOCOL_INFO class methodsFor!

defineFields
	"Define the fields of the HTTP_SSL_PROTOCOL_INFO structure.

	HTTP_SSL_PROTOCOL_INFO compileDefinition

		typedef [uuid(73784afd-f4e5-464e-b716-46ebb0c8c6d1), helpstring('HttpRequestInfoTypeSslProtocol payload. Contains basic information about the SSL/TLS protocol and cipher. See SecPkgContext_ConnectionInfo documentation for details.')]
		struct tagHTTP_SSL_PROTOCOL_INFO {
			[readonly] ULONG Protocol;
			[readonly] ULONG CipherType;
			[readonly] ULONG CipherStrength;
			[readonly] ULONG HashType;
			[readonly] ULONG HashStrength;
			[readonly] ULONG KeyExchangeType;
			[readonly] ULONG KeyExchangeStrength;
		} HTTP_SSL_PROTOCOL_INFO;
"

	self
		defineField: #Protocol type: DWORDField new beReadOnly offset: 0;
		defineField: #CipherType type: DWORDField new beReadOnly offset: 4;
		defineField: #CipherStrength type: DWORDField new beReadOnly offset: 8;
		defineField: #HashType type: DWORDField new beReadOnly offset: 12;
		defineField: #HashStrength type: DWORDField new beReadOnly offset: 16;
		defineField: #KeyExchangeType type: DWORDField new beReadOnly offset: 20;
		defineField: #KeyExchangeStrength type: DWORDField new beReadOnly offset: 24.
	self byteSize: 28! !
!HTTP_SSL_PROTOCOL_INFO class categoriesFor: #defineFields!**auto generated**!initializing!public! !

