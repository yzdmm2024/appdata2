//
//  AppData2-Prefix.h
//  AppData2
//
//  Fork of AppData (https://github.com/FouadRaheb/AppData)
//  Injected via -include so the original .pch-based build keeps working.
//

#ifdef __OBJC__
    #import <Foundation/Foundation.h>
    #import <UIKit/UIKit.h>
#endif

// Logos' %log expands to HBLogDebug; theos' Prefix.pch normally provides it.
#ifndef HBLogDebug
    #define HBLogDebug(...)     do {} while (0)
#endif

#import "Headers.h"
#import "ADHelper.h"
#import "ADSettings.h"

#ifdef DEBUG
    #define NSLog(...)          NSLog(@"[AppData2]: %@", [NSString stringWithFormat:__VA_ARGS__])
#else
    #define NSLog(...)
#endif

#define ASYNC(...)              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ __VA_ARGS__; })
#define ASYNC_MAIN(...)         dispatch_async(dispatch_get_main_queue(), ^{ __VA_ARGS__ })
#define DISPATCH_AFTER(t,...)   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, t * NSEC_PER_SEC), dispatch_get_main_queue(), ^{ __VA_ARGS__ })

#define IS_IPAD                 UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad