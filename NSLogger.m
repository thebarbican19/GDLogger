//
//  NSLogger.m
//  Video Downloader
//
//  Created by Joe Barbour on 21/04/2015.
//  Copyright (c) 2015 NorthernSpark. All rights reserved.
//

#import "NSLogger.h"

#define LOGGER_DIRECTORY [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"logger"]
#define LOGGER_APP [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
#define LOGGER_BUNDLE [[NSBundle mainBundle] bundleIdentifier]
#define LOGGER_DEVICE_NAME [UIDevice currentDevice].name
#define LOGGER_LANGUAGE [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[[NSLocale currentLocale] localeIdentifier]]
#define LOGGER_DEVICE_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define LOGGER_APP_FORMATTED [[LOGGER_APP stringByReplacingOccurrencesOfString:@" " withString:@"-"] lowercaseString]
#define LOGGER_FILENAME [NSString stringWithFormat:@"%@-logger.txt" ,LOGGER_APP_FORMATTED]
#define LOGGER_VERSION 1.1
#define LOGGER_HEADER [NSString stringWithFormat:@"Created with NorthernSpark Logger (Version %.1f)\nLog Created: %@\nApp Name: %@\nApp Bundle Identifyer: %@\nDevice: %@ (iOS %.1f)\nLocalization: %@\n\n" ,LOGGER_VERSION, [self formatDate], LOGGER_APP, LOGGER_BUNDLE, LOGGER_DEVICE_NAME, LOGGER_DEVICE_VERSION, LOGGER_LANGUAGE]

@implementation NSLogger

-(NSString *)formatDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:@"HH:mm:ss EEE dd/MM/yyyy"];
    
    return [formatter stringFromDate:[NSDate date]];
    
}

-(void)log:(NSString *)title properties:(NSDictionary *)properties error:(BOOL)error {
    NSMutableString *appendContents = [[NSMutableString alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:LOGGER_DIRECTORY]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:LOGGER_DIRECTORY withIntermediateDirectories:false attributes:nil error:nil];
        
        [appendContents appendString:LOGGER_HEADER];
        
        if (self.degbugger) NSLog(@"NSLogger file created: %@" ,LOGGER_FILENAME);
        
    }
    
    [appendContents appendString:[self logPrint]];
    [appendContents appendString:[NSString stringWithFormat:@"\n\n****************************** %@ ******************************\n" ,[self formatDate]]];
    
    NSAssert(title != nil, @"Event title cannot be nill");
    NSAssert(title.length > 2, @"Event title needs to be longer that 2 characters");

    [appendContents appendString:[NSString stringWithFormat:@"\nEVENT: \"%@\"\nERROR: %@\nPROPERTIES ¬ \n" ,error?@"TRUE":@"FALSE", title]];
    
    for (int i = 0; i < [[properties allKeys] count]; i++) {
        NSAssert([properties objectForKey:[[properties allKeys] objectAtIndex:i]] != [NSNull null], @"Event property cannot be null");
        [appendContents appendString:[NSString stringWithFormat:@"%@: \"%@\"\n" ,[[properties allKeys] objectAtIndex:i], [properties objectForKey:[[properties allKeys] objectAtIndex:i]]]];

    }
    
    [appendContents appendString:@"\n"];

    NSError *writingError;
    if (![appendContents writeToURL:[self logDirectory] atomically:true encoding:NSUTF8StringEncoding error:&writingError]) {
        if (self.degbugger) NSLog(@"NSLogger was not updated due to error: %@" ,writingError);

    }
    else {
        if (self.degbugger) NSLog(@"NSLogger event \"%@\" added" ,title);
        
    }

}

-(NSURL *)logDirectory {
    return [NSURL fileURLWithPath:[LOGGER_DIRECTORY stringByAppendingPathComponent:LOGGER_FILENAME]];
    
}

-(NSString *)logPrint {
    if ([[NSString stringWithContentsOfFile:[LOGGER_DIRECTORY stringByAppendingPathComponent:LOGGER_FILENAME] encoding:NSUTF8StringEncoding error:NULL] length] != 0)
        return [NSString stringWithContentsOfFile:[LOGGER_DIRECTORY stringByAppendingPathComponent:LOGGER_FILENAME] encoding:NSUTF8StringEncoding error:NULL];
    else return @"";
    
}

-(NSData *)logData {
    return [[NSFileManager defaultManager] contentsAtPath:[LOGGER_DIRECTORY stringByAppendingPathComponent:LOGGER_FILENAME]];
    
}


@end
