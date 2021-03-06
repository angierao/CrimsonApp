// Generated by Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import Foundation;
@import ObjectiveC;
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

@interface NSData (SWIFT_EXTENSION(Haneke))
+ (NSData * __nullable)convertFromData:(NSData * __nonnull)data;
- (NSData * __null_unspecified)asData;
@end


@interface NSFileManager (SWIFT_EXTENSION(Haneke))
@end


@interface NSHTTPURLResponse (SWIFT_EXTENSION(Haneke))
- (BOOL)hnk_isValidStatusCode;
@end


@interface NSMutableData (SWIFT_EXTENSION(Haneke))
@end


@interface NSURLResponse (SWIFT_EXTENSION(Haneke))
- (BOOL)hnk_validateLengthOfData:(NSData * __nonnull)data;
@end


SWIFT_CLASS("_TtC6Haneke13ObjectWrapper")
@interface ObjectWrapper : NSObject
@end

@class UIImage;

@interface UIButton (SWIFT_EXTENSION(Haneke))
- (void)hnk_cancelSetImage;
- (void)hnk_setImage:(UIImage * __nonnull)image state:(UIControlState)state animated:(BOOL)animated success:(void (^ __nullable)(UIImage * __nonnull))succeed;
- (BOOL)hnk_shouldCancelImageForKey:(NSString * __nonnull)key;
- (void)hnk_cancelSetBackgroundImage;
- (void)hnk_setBackgroundImage:(UIImage * __nonnull)image state:(UIControlState)state animated:(BOOL)animated success:(void (^ __nullable)(UIImage * __nonnull))succeed;
- (BOOL)hnk_shouldCancelBackgroundImageForKey:(NSString * __nonnull)key;
@end


@interface UIImage (SWIFT_EXTENSION(Haneke))
- (UIImage * __nonnull)hnk_imageByScalingToSize:(CGSize)toSize;
- (BOOL)hnk_hasAlpha;
- (NSData * __null_unspecified)hnk_dataWithCompressionQuality:(float)compressionQuality;
- (UIImage * __null_unspecified)hnk_decompressedImage;
@end


@interface UIImage (SWIFT_EXTENSION(Haneke))
+ (UIImage * __nullable)safeImageWithData:(NSData * __nonnull)data;
+ (UIImage * __nullable)convertFromData:(NSData * __nonnull)data;
- (NSData * __null_unspecified)asData;
@end


@interface UIImageView (SWIFT_EXTENSION(Haneke))
- (void)hnk_cancelSetImage;
- (void)hnk_setImage:(UIImage * __nonnull)image animated:(BOOL)animated success:(void (^ __nullable)(UIImage * __nonnull))succeed;
- (BOOL)hnk_shouldCancelForKey:(NSString * __nonnull)key;
@end

#pragma clang diagnostic pop
