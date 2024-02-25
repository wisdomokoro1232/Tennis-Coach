#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "Cricket1" asset catalog image resource.
static NSString * const ACImageNameCricket1 AC_SWIFT_PRIVATE = @"Cricket1";

/// The "Cricket2" asset catalog image resource.
static NSString * const ACImageNameCricket2 AC_SWIFT_PRIVATE = @"Cricket2";

/// The "Cricket3" asset catalog image resource.
static NSString * const ACImageNameCricket3 AC_SWIFT_PRIVATE = @"Cricket3";

/// The "Sherry" asset catalog image resource.
static NSString * const ACImageNameSherry AC_SWIFT_PRIVATE = @"Sherry";

/// The "maki-cricket" asset catalog image resource.
static NSString * const ACImageNameMakiCricket AC_SWIFT_PRIVATE = @"maki-cricket";

#undef AC_SWIFT_PRIVATE