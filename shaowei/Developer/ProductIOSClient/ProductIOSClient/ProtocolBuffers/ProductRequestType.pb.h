// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class ProductClientInstruction;
@class ProductClientInstruction_Builder;
@class ProductConfirmRequest;
@class ProductConfirmRequest_Builder;
@class ProductInteractiveQuestion;
@class ProductInteractiveQuestion_Builder;
@class ProductRequest;
@class ProductRequest_Builder;
@class ProductResponse;
@class ProductResponseStatus;
@class ProductResponseStatus_Builder;
@class ProductResponse_Builder;
@class Property;
@class Property_Builder;
#ifndef __has_feature
  #define __has_feature(x) 0 // Compatibility with non-clang compilers.
#endif // __has_feature

#ifndef NS_RETURNS_NOT_RETAINED
  #if __has_feature(attribute_ns_returns_not_retained)
    #define NS_RETURNS_NOT_RETAINED __attribute__((ns_returns_not_retained))
  #else
    #define NS_RETURNS_NOT_RETAINED
  #endif
#endif


@interface ProductRequestTypeRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface Property : PBGeneratedMessage {
@private
  BOOL hasKey_:1;
  BOOL hasValue_:1;
  NSString* key;
  NSString* value;
}
- (BOOL) hasKey;
- (BOOL) hasValue;
@property (readonly, retain) NSString* key;
@property (readonly, retain) NSString* value;

+ (Property*) defaultInstance;
- (Property*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (Property_Builder*) builder;
+ (Property_Builder*) builder;
+ (Property_Builder*) builderWithPrototype:(Property*) prototype;
- (Property_Builder*) toBuilder;

+ (Property*) parseFromData:(NSData*) data;
+ (Property*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Property*) parseFromInputStream:(NSInputStream*) input;
+ (Property*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (Property*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (Property*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface Property_Builder : PBGeneratedMessage_Builder {
@private
  Property* result;
}

- (Property*) defaultInstance;

- (Property_Builder*) clear;
- (Property_Builder*) clone;

- (Property*) build;
- (Property*) buildPartial;

- (Property_Builder*) mergeFrom:(Property*) other;
- (Property_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (Property_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasKey;
- (NSString*) key;
- (Property_Builder*) setKey:(NSString*) value;
- (Property_Builder*) clearKey;

- (BOOL) hasValue;
- (NSString*) value;
- (Property_Builder*) setValue:(NSString*) value;
- (Property_Builder*) clearValue;
@end

@interface ProductRequest : PBGeneratedMessage {
@private
  BOOL hasQuestion_:1;
  BOOL hasTransactionId_:1;
  NSString* question;
  NSString* transactionId;
  PBAppendableArray * propertiesArray;
}
- (BOOL) hasQuestion;
- (BOOL) hasTransactionId;
@property (readonly, retain) NSString* question;
@property (readonly, retain) PBArray * properties;
@property (readonly, retain) NSString* transactionId;
- (Property*)propertiesAtIndex:(NSUInteger)index;

+ (ProductRequest*) defaultInstance;
- (ProductRequest*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ProductRequest_Builder*) builder;
+ (ProductRequest_Builder*) builder;
+ (ProductRequest_Builder*) builderWithPrototype:(ProductRequest*) prototype;
- (ProductRequest_Builder*) toBuilder;

+ (ProductRequest*) parseFromData:(NSData*) data;
+ (ProductRequest*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductRequest*) parseFromInputStream:(NSInputStream*) input;
+ (ProductRequest*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductRequest*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ProductRequest*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ProductRequest_Builder : PBGeneratedMessage_Builder {
@private
  ProductRequest* result;
}

- (ProductRequest*) defaultInstance;

- (ProductRequest_Builder*) clear;
- (ProductRequest_Builder*) clone;

- (ProductRequest*) build;
- (ProductRequest*) buildPartial;

- (ProductRequest_Builder*) mergeFrom:(ProductRequest*) other;
- (ProductRequest_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ProductRequest_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasQuestion;
- (NSString*) question;
- (ProductRequest_Builder*) setQuestion:(NSString*) value;
- (ProductRequest_Builder*) clearQuestion;

- (PBAppendableArray *)properties;
- (Property*)propertiesAtIndex:(NSUInteger)index;
- (ProductRequest_Builder *)addProperties:(Property*)value;
- (ProductRequest_Builder *)setPropertiesArray:(NSArray *)array;
- (ProductRequest_Builder *)setPropertiesValues:(const Property* *)values count:(NSUInteger)count;
- (ProductRequest_Builder *)clearProperties;

- (BOOL) hasTransactionId;
- (NSString*) transactionId;
- (ProductRequest_Builder*) setTransactionId:(NSString*) value;
- (ProductRequest_Builder*) clearTransactionId;
@end

@interface ProductConfirmRequest : PBGeneratedMessage {
@private
  BOOL hasQuestion_:1;
  BOOL hasServer_:1;
  BOOL hasTransactionId_:1;
  BOOL hasPreInstruction_:1;
  BOOL hasPreQuestion_:1;
  NSString* question;
  NSString* server;
  NSString* transactionId;
  ProductClientInstruction* preInstruction;
  ProductInteractiveQuestion* preQuestion;
  PBAppendableArray * propertiesArray;
}
- (BOOL) hasQuestion;
- (BOOL) hasServer;
- (BOOL) hasPreInstruction;
- (BOOL) hasPreQuestion;
- (BOOL) hasTransactionId;
@property (readonly, retain) NSString* question;
@property (readonly, retain) PBArray * properties;
@property (readonly, retain) NSString* server;
@property (readonly, retain) ProductClientInstruction* preInstruction;
@property (readonly, retain) ProductInteractiveQuestion* preQuestion;
@property (readonly, retain) NSString* transactionId;
- (Property*)propertiesAtIndex:(NSUInteger)index;

+ (ProductConfirmRequest*) defaultInstance;
- (ProductConfirmRequest*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ProductConfirmRequest_Builder*) builder;
+ (ProductConfirmRequest_Builder*) builder;
+ (ProductConfirmRequest_Builder*) builderWithPrototype:(ProductConfirmRequest*) prototype;
- (ProductConfirmRequest_Builder*) toBuilder;

+ (ProductConfirmRequest*) parseFromData:(NSData*) data;
+ (ProductConfirmRequest*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductConfirmRequest*) parseFromInputStream:(NSInputStream*) input;
+ (ProductConfirmRequest*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductConfirmRequest*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ProductConfirmRequest*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ProductConfirmRequest_Builder : PBGeneratedMessage_Builder {
@private
  ProductConfirmRequest* result;
}

- (ProductConfirmRequest*) defaultInstance;

- (ProductConfirmRequest_Builder*) clear;
- (ProductConfirmRequest_Builder*) clone;

- (ProductConfirmRequest*) build;
- (ProductConfirmRequest*) buildPartial;

- (ProductConfirmRequest_Builder*) mergeFrom:(ProductConfirmRequest*) other;
- (ProductConfirmRequest_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ProductConfirmRequest_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasQuestion;
- (NSString*) question;
- (ProductConfirmRequest_Builder*) setQuestion:(NSString*) value;
- (ProductConfirmRequest_Builder*) clearQuestion;

- (PBAppendableArray *)properties;
- (Property*)propertiesAtIndex:(NSUInteger)index;
- (ProductConfirmRequest_Builder *)addProperties:(Property*)value;
- (ProductConfirmRequest_Builder *)setPropertiesArray:(NSArray *)array;
- (ProductConfirmRequest_Builder *)setPropertiesValues:(const Property* *)values count:(NSUInteger)count;
- (ProductConfirmRequest_Builder *)clearProperties;

- (BOOL) hasServer;
- (NSString*) server;
- (ProductConfirmRequest_Builder*) setServer:(NSString*) value;
- (ProductConfirmRequest_Builder*) clearServer;

- (BOOL) hasPreInstruction;
- (ProductClientInstruction*) preInstruction;
- (ProductConfirmRequest_Builder*) setPreInstruction:(ProductClientInstruction*) value;
- (ProductConfirmRequest_Builder*) setPreInstructionBuilder:(ProductClientInstruction_Builder*) builderForValue;
- (ProductConfirmRequest_Builder*) mergePreInstruction:(ProductClientInstruction*) value;
- (ProductConfirmRequest_Builder*) clearPreInstruction;

- (BOOL) hasPreQuestion;
- (ProductInteractiveQuestion*) preQuestion;
- (ProductConfirmRequest_Builder*) setPreQuestion:(ProductInteractiveQuestion*) value;
- (ProductConfirmRequest_Builder*) setPreQuestionBuilder:(ProductInteractiveQuestion_Builder*) builderForValue;
- (ProductConfirmRequest_Builder*) mergePreQuestion:(ProductInteractiveQuestion*) value;
- (ProductConfirmRequest_Builder*) clearPreQuestion;

- (BOOL) hasTransactionId;
- (NSString*) transactionId;
- (ProductConfirmRequest_Builder*) setTransactionId:(NSString*) value;
- (ProductConfirmRequest_Builder*) clearTransactionId;
@end

@interface ProductClientInstruction : PBGeneratedMessage {
@private
  BOOL hasType_:1;
  NSString* type;
  PBAppendableArray * featuresArray;
}
- (BOOL) hasType;
@property (readonly, retain) NSString* type;
@property (readonly, retain) PBArray * features;
- (Property*)featuresAtIndex:(NSUInteger)index;

+ (ProductClientInstruction*) defaultInstance;
- (ProductClientInstruction*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ProductClientInstruction_Builder*) builder;
+ (ProductClientInstruction_Builder*) builder;
+ (ProductClientInstruction_Builder*) builderWithPrototype:(ProductClientInstruction*) prototype;
- (ProductClientInstruction_Builder*) toBuilder;

+ (ProductClientInstruction*) parseFromData:(NSData*) data;
+ (ProductClientInstruction*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductClientInstruction*) parseFromInputStream:(NSInputStream*) input;
+ (ProductClientInstruction*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductClientInstruction*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ProductClientInstruction*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ProductClientInstruction_Builder : PBGeneratedMessage_Builder {
@private
  ProductClientInstruction* result;
}

- (ProductClientInstruction*) defaultInstance;

- (ProductClientInstruction_Builder*) clear;
- (ProductClientInstruction_Builder*) clone;

- (ProductClientInstruction*) build;
- (ProductClientInstruction*) buildPartial;

- (ProductClientInstruction_Builder*) mergeFrom:(ProductClientInstruction*) other;
- (ProductClientInstruction_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ProductClientInstruction_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasType;
- (NSString*) type;
- (ProductClientInstruction_Builder*) setType:(NSString*) value;
- (ProductClientInstruction_Builder*) clearType;

- (PBAppendableArray *)features;
- (Property*)featuresAtIndex:(NSUInteger)index;
- (ProductClientInstruction_Builder *)addFeatures:(Property*)value;
- (ProductClientInstruction_Builder *)setFeaturesArray:(NSArray *)array;
- (ProductClientInstruction_Builder *)setFeaturesValues:(const Property* *)values count:(NSUInteger)count;
- (ProductClientInstruction_Builder *)clearFeatures;
@end

@interface ProductInteractiveQuestion : PBGeneratedMessage {
@private
  BOOL hasType_:1;
  BOOL hasDisplay_:1;
  BOOL hasField_:1;
  NSString* type;
  NSString* display;
  NSString* field;
  PBAppendableArray * optionsArray;
}
- (BOOL) hasType;
- (BOOL) hasDisplay;
- (BOOL) hasField;
@property (readonly, retain) NSString* type;
@property (readonly, retain) NSString* display;
@property (readonly, retain) NSString* field;
@property (readonly, retain) PBArray * options;
- (Property*)optionsAtIndex:(NSUInteger)index;

+ (ProductInteractiveQuestion*) defaultInstance;
- (ProductInteractiveQuestion*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ProductInteractiveQuestion_Builder*) builder;
+ (ProductInteractiveQuestion_Builder*) builder;
+ (ProductInteractiveQuestion_Builder*) builderWithPrototype:(ProductInteractiveQuestion*) prototype;
- (ProductInteractiveQuestion_Builder*) toBuilder;

+ (ProductInteractiveQuestion*) parseFromData:(NSData*) data;
+ (ProductInteractiveQuestion*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductInteractiveQuestion*) parseFromInputStream:(NSInputStream*) input;
+ (ProductInteractiveQuestion*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductInteractiveQuestion*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ProductInteractiveQuestion*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ProductInteractiveQuestion_Builder : PBGeneratedMessage_Builder {
@private
  ProductInteractiveQuestion* result;
}

- (ProductInteractiveQuestion*) defaultInstance;

- (ProductInteractiveQuestion_Builder*) clear;
- (ProductInteractiveQuestion_Builder*) clone;

- (ProductInteractiveQuestion*) build;
- (ProductInteractiveQuestion*) buildPartial;

- (ProductInteractiveQuestion_Builder*) mergeFrom:(ProductInteractiveQuestion*) other;
- (ProductInteractiveQuestion_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ProductInteractiveQuestion_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasType;
- (NSString*) type;
- (ProductInteractiveQuestion_Builder*) setType:(NSString*) value;
- (ProductInteractiveQuestion_Builder*) clearType;

- (BOOL) hasDisplay;
- (NSString*) display;
- (ProductInteractiveQuestion_Builder*) setDisplay:(NSString*) value;
- (ProductInteractiveQuestion_Builder*) clearDisplay;

- (BOOL) hasField;
- (NSString*) field;
- (ProductInteractiveQuestion_Builder*) setField:(NSString*) value;
- (ProductInteractiveQuestion_Builder*) clearField;

- (PBAppendableArray *)options;
- (Property*)optionsAtIndex:(NSUInteger)index;
- (ProductInteractiveQuestion_Builder *)addOptions:(Property*)value;
- (ProductInteractiveQuestion_Builder *)setOptionsArray:(NSArray *)array;
- (ProductInteractiveQuestion_Builder *)setOptionsValues:(const Property* *)values count:(NSUInteger)count;
- (ProductInteractiveQuestion_Builder *)clearOptions;
@end

@interface ProductResponseStatus : PBGeneratedMessage {
@private
  BOOL hasCode_:1;
  BOOL hasMessage_:1;
  NSString* code;
  NSString* message;
}
- (BOOL) hasCode;
- (BOOL) hasMessage;
@property (readonly, retain) NSString* code;
@property (readonly, retain) NSString* message;

+ (ProductResponseStatus*) defaultInstance;
- (ProductResponseStatus*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ProductResponseStatus_Builder*) builder;
+ (ProductResponseStatus_Builder*) builder;
+ (ProductResponseStatus_Builder*) builderWithPrototype:(ProductResponseStatus*) prototype;
- (ProductResponseStatus_Builder*) toBuilder;

+ (ProductResponseStatus*) parseFromData:(NSData*) data;
+ (ProductResponseStatus*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductResponseStatus*) parseFromInputStream:(NSInputStream*) input;
+ (ProductResponseStatus*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductResponseStatus*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ProductResponseStatus*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ProductResponseStatus_Builder : PBGeneratedMessage_Builder {
@private
  ProductResponseStatus* result;
}

- (ProductResponseStatus*) defaultInstance;

- (ProductResponseStatus_Builder*) clear;
- (ProductResponseStatus_Builder*) clone;

- (ProductResponseStatus*) build;
- (ProductResponseStatus*) buildPartial;

- (ProductResponseStatus_Builder*) mergeFrom:(ProductResponseStatus*) other;
- (ProductResponseStatus_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ProductResponseStatus_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasCode;
- (NSString*) code;
- (ProductResponseStatus_Builder*) setCode:(NSString*) value;
- (ProductResponseStatus_Builder*) clearCode;

- (BOOL) hasMessage;
- (NSString*) message;
- (ProductResponseStatus_Builder*) setMessage:(NSString*) value;
- (ProductResponseStatus_Builder*) clearMessage;
@end

@interface ProductResponse : PBGeneratedMessage {
@private
  BOOL hasNeedInteract_:1;
  BOOL hasAnswer_:1;
  BOOL hasServer_:1;
  BOOL hasStatus_:1;
  BOOL hasPreInstruction_:1;
  BOOL hasPreQuestion_:1;
  BOOL needInteract_:1;
  NSString* answer;
  NSString* server;
  ProductResponseStatus* status;
  ProductClientInstruction* preInstruction;
  ProductInteractiveQuestion* preQuestion;
  PBAppendableArray * propertiesArray;
}
- (BOOL) hasStatus;
- (BOOL) hasAnswer;
- (BOOL) hasServer;
- (BOOL) hasNeedInteract;
- (BOOL) hasPreInstruction;
- (BOOL) hasPreQuestion;
@property (readonly, retain) ProductResponseStatus* status;
@property (readonly, retain) NSString* answer;
@property (readonly, retain) NSString* server;
- (BOOL) needInteract;
@property (readonly, retain) ProductClientInstruction* preInstruction;
@property (readonly, retain) ProductInteractiveQuestion* preQuestion;
@property (readonly, retain) PBArray * properties;
- (Property*)propertiesAtIndex:(NSUInteger)index;

+ (ProductResponse*) defaultInstance;
- (ProductResponse*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (ProductResponse_Builder*) builder;
+ (ProductResponse_Builder*) builder;
+ (ProductResponse_Builder*) builderWithPrototype:(ProductResponse*) prototype;
- (ProductResponse_Builder*) toBuilder;

+ (ProductResponse*) parseFromData:(NSData*) data;
+ (ProductResponse*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductResponse*) parseFromInputStream:(NSInputStream*) input;
+ (ProductResponse*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (ProductResponse*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (ProductResponse*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface ProductResponse_Builder : PBGeneratedMessage_Builder {
@private
  ProductResponse* result;
}

- (ProductResponse*) defaultInstance;

- (ProductResponse_Builder*) clear;
- (ProductResponse_Builder*) clone;

- (ProductResponse*) build;
- (ProductResponse*) buildPartial;

- (ProductResponse_Builder*) mergeFrom:(ProductResponse*) other;
- (ProductResponse_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (ProductResponse_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasStatus;
- (ProductResponseStatus*) status;
- (ProductResponse_Builder*) setStatus:(ProductResponseStatus*) value;
- (ProductResponse_Builder*) setStatusBuilder:(ProductResponseStatus_Builder*) builderForValue;
- (ProductResponse_Builder*) mergeStatus:(ProductResponseStatus*) value;
- (ProductResponse_Builder*) clearStatus;

- (BOOL) hasAnswer;
- (NSString*) answer;
- (ProductResponse_Builder*) setAnswer:(NSString*) value;
- (ProductResponse_Builder*) clearAnswer;

- (BOOL) hasServer;
- (NSString*) server;
- (ProductResponse_Builder*) setServer:(NSString*) value;
- (ProductResponse_Builder*) clearServer;

- (BOOL) hasNeedInteract;
- (BOOL) needInteract;
- (ProductResponse_Builder*) setNeedInteract:(BOOL) value;
- (ProductResponse_Builder*) clearNeedInteract;

- (BOOL) hasPreInstruction;
- (ProductClientInstruction*) preInstruction;
- (ProductResponse_Builder*) setPreInstruction:(ProductClientInstruction*) value;
- (ProductResponse_Builder*) setPreInstructionBuilder:(ProductClientInstruction_Builder*) builderForValue;
- (ProductResponse_Builder*) mergePreInstruction:(ProductClientInstruction*) value;
- (ProductResponse_Builder*) clearPreInstruction;

- (BOOL) hasPreQuestion;
- (ProductInteractiveQuestion*) preQuestion;
- (ProductResponse_Builder*) setPreQuestion:(ProductInteractiveQuestion*) value;
- (ProductResponse_Builder*) setPreQuestionBuilder:(ProductInteractiveQuestion_Builder*) builderForValue;
- (ProductResponse_Builder*) mergePreQuestion:(ProductInteractiveQuestion*) value;
- (ProductResponse_Builder*) clearPreQuestion;

- (PBAppendableArray *)properties;
- (Property*)propertiesAtIndex:(NSUInteger)index;
- (ProductResponse_Builder *)addProperties:(Property*)value;
- (ProductResponse_Builder *)setPropertiesArray:(NSArray *)array;
- (ProductResponse_Builder *)setPropertiesValues:(const Property* *)values count:(NSUInteger)count;
- (ProductResponse_Builder *)clearProperties;
@end

