//
//  ADHelper.m
//  AppData
//
//  Created by Fouad Raheb on 6/29/20.
//

#import "ADHelper.h"
#import <dlfcn.h>

// Resolves the resources bundle on both rootful (/Library) and rootless (/var/jb)
// jailbreaks, falling back to a path derived from this dylib's own location.
static NSString *ADResourcesBundlePath(void) {
    static NSString *path;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray <NSString *> *candidates = @[
            @"/var/jb/Library/Application Support/AppData2/Resources.bundle",
            @"/Library/Application Support/AppData2/Resources.bundle",
        ];
        for (NSString *candidate in candidates) {
            if ([fm fileExistsAtPath:candidate]) {
                path = candidate;
                break;
            }
        }
        if (!path) {
            Dl_info info;
            if (dladdr((const void *)&ADResourcesBundlePath, &info) && info.dli_fname) {
                NSString *dylibPath = [NSString stringWithUTF8String:info.dli_fname];
                NSRange range = [dylibPath rangeOfString:@"/Library/MobileSubstrate/DynamicLibraries/"];
                if (range.location != NSNotFound) {
                    NSString *prefix = [dylibPath substringToIndex:range.location];
                    path = [prefix stringByAppendingString:@"/Library/Application Support/AppData2/Resources.bundle"];
                }
            }
        }
        if (!path) {
            path = candidates.firstObject;
        }
    });
    return path;
}

@interface ADHelper ()
@property (nonatomic, strong) NSBundle *resoucesBundle;
@end

@implementation ADHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t p = 0;
    __strong static ADHelper *_sharedInstance = nil;
    dispatch_once(&p, ^{
        _sharedInstance = [[self alloc] init];
        // Create resources bundle
        _sharedInstance.resoucesBundle = [NSBundle bundleWithPath:ADResourcesBundlePath()];
    });
    return _sharedInstance;
}

#pragma mark - Resources

+ (UIImage *)imageNamed:(NSString *)imageName {
    return [UIImage imageNamed:imageName inBundle:ADHelper.sharedInstance.resoucesBundle];
}

#pragma mark - Helpers

+ (void)openDirectoryAtURL:(NSURL *)url fromController:(UIViewController *)controller {
    NSString *path = [url.path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"filza://"]]) {
        NSURL *filzaURL = [NSURL URLWithString:[@"filza://view" stringByAppendingString:path]];
        [[UIApplication sharedApplication] openURL:filzaURL options:@{} completionHandler:nil];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ifile://"]]) {
        NSURL *ifileURL = [NSURL URLWithString:[@"ifile://file://" stringByAppendingString:path]];
        [[UIApplication sharedApplication] openURL:ifileURL options:@{} completionHandler:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"AppData2" message:@"Install Filza app to open the selected directory" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
        [controller presentViewController:alertController animated:YES completion:nil];
    }
}

+ (SBSApplicationShortcutItem *)applicationShortcutItem {
    SBSApplicationShortcutItem *shortcutItem = [[NSClassFromString(@"SBSApplicationShortcutItem") alloc] init];
    shortcutItem.localizedTitle = @"AppData2";
    shortcutItem.type = kSBApplicationShortcutItemType;
    
    NSData *imageData = nil;
    if (@available(iOS 13, *)) {
        if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
            imageData = UIImagePNGRepresentation([[self imageNamed:@"AppDataIconWhite"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]);
        } else {
            imageData = UIImagePNGRepresentation([[self imageNamed:@"AppDataIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]);
        }
    } else {
        imageData = UIImagePNGRepresentation([[self imageNamed:@"AppDataIcon12"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]);
    }
    if (imageData) {
        SBSApplicationShortcutCustomImageIcon *iconImage = [[NSClassFromString(@"SBSApplicationShortcutCustomImageIcon") alloc] initWithImagePNGData:imageData];
        [shortcutItem setIcon:iconImage];
    }
    return shortcutItem;
}

@end
