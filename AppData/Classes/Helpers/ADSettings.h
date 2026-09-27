//
//  ADSettings.m
//  AppData
//
//  Created by Fouad Raheb on 3/29/21.
//

#import <Foundation/Foundation.h>
#import "ADAppearance.h"

// Keys
#define kSwipeUpEnabled                                     @"SwipeUpEnabled"
#define kForceTouchMenuEnabled                              @"ForceTouchMenuEnabled"
#define kAppearance                                         @"kAppearance"

#define kCustomAppNames                                     @"CustomAppNames"

// Safe Clean: keep the app's Documents folder (user files / game saves) as well.
#define kSafeCleanKeepsDocuments                            @"SafeCleanKeepsDocuments"

// Notification
#define kAppDataSwipeUpPreferencesChangedNotification       @"com.yzdmm.appdata2.swipeup-preferences-changed"
#define kAppDataAppearancePreferencesChangedNotification    @"com.yzdmm.appdata2.appearance-preferences-changed"

@interface ADSettings : NSObject

@property (nonatomic, strong) NSUserDefaults *userDefaults;

+ (instancetype)sharedInstance;

+ (id)objectForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (void)setObject:(id)object forKey:(NSString *)key;
+ (void)setInteger:(NSInteger)integer forKey:(NSString *)key;

#pragma mark - Activation
+ (BOOL)swipeUpEnabled;
+ (BOOL)forceTouchMenuEnabled;

#pragma mark - App Names
+ (NSString *)customAppNameForBundleIdentifier:(NSString *)identifier;
+ (void)setCustomAppName:(NSString *)name forBundleIdentifier:(NSString *)bundleIdentifier;

#pragma mark - Safe Clean
+ (BOOL)safeCleanKeepsDocuments;

#pragma mark - Appearance
+ (ADAppearanceStyle)appearanceStyle;
+ (NSArray <NSString *> *)appearanceValues;
+ (NSArray <NSString *> *)appearanceTitles;
+ (NSString *)titleForAppearanceStyle:(ADAppearanceStyle)style;

@end
