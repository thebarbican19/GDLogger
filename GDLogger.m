//
//  GDLogger.m
//  Grado Logger https://gradoapp.com
//
//  Created by Joe Barbour on 21/04/2015.
//  Copyright (c) 2015 NorthernSpark. All rights reserved.
//

#import "GDLogger.h"

#define LOGGER_DIRECTORY [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"logger"]
#define LOGGER_APP [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
#define LOGGER_BUNDLE [[NSBundle mainBundle] bundleIdentifier]
#define LOGGER_DEVICE_NAME [UIDevice currentDevice].name
#define LOGGER_LANGUAGE [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[[NSLocale currentLocale] localeIdentifier]]
#define LOGGER_DEVICE_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define LOGGER_APP_FORMATTED [[LOGGER_APP stringByReplacingOccurrencesOfString:@" " withString:@"-"] lowercaseString]
#define LOGGER_FILENAME [NSString stringWithFormat:@"%@-logger.txt" ,LOGGER_APP_FORMATTED]
#define LOGGER_VERSION 1.1
#define LOGGER_HEADER [NSString stringWithFormat:@"\n\nCreated with NorthernSpark Logger (Version %.1f)\nLog Created: %@\nApp Name: %@\nApp Bundle Identifyer: %@\nDevice: %@ (iOS %.1f)\nLocalization: %@\n" ,LOGGER_VERSION, [self formatDate], LOGGER_APP, LOGGER_BUNDLE, LOGGER_DEVICE_NAME, LOGGER_DEVICE_VERSION, LOGGER_LANGUAGE]

@implementation GDLogger

-(NSString *)formatDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:@"HH:mm:ss EEE dd/MM/yyyy"];
    
    return [formatter stringFromDate:[NSDate date]];
    
}

-(void)log:(NSString *)title properties:(NSDictionary *)properties error:(BOOL)error {
    if (!self.filename) self.filename = LOGGER_FILENAME;
    else self.filename = [NSString stringWithFormat:@"%@-%@.txt" ,LOGGER_APP_FORMATTED, self.filename];
    
    NSMutableString *appendContents = [[NSMutableString alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:LOGGER_DIRECTORY]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:LOGGER_DIRECTORY withIntermediateDirectories:false attributes:nil error:nil];
        
        [appendContents appendString:LOGGER_HEADER];
        
        if (self.degbugger) NSLog(@"NSLogger file created: %@" ,self.filename);
        
    }
    
    [appendContents appendString:[self logPrint]];
    [appendContents appendString:[NSString stringWithFormat:@"\n****************************** %@ ******************************\n" ,[self formatDate]]];
    
    NSAssert(title != nil, @"Event title cannot be nill");
    NSAssert(title.length > 2, @"Event title needs to be longer that 2 characters");

    [appendContents appendString:[NSString stringWithFormat:@"\nEVENT: \"%@\"\nERROR: %@\nPROPERTIES ¬ " ,title ,error?@"TRUE":@"FALSE"]];
    
    for (int i = 0; i < [[properties allKeys] count]; i++) {
        if ([properties objectForKey:[[properties allKeys] objectAtIndex:i]] != [NSNull null]) {
            [appendContents appendString:[NSString stringWithFormat:@"%@: \"%@\"\n" ,[[properties allKeys] objectAtIndex:i], [properties objectForKey:[[properties allKeys] objectAtIndex:i]]]];
            
        }
        else {
            [appendContents appendString:[NSString stringWithFormat:@"%@: \"%@\"\n" ,[[properties allKeys] objectAtIndex:i], @"null"]];

        }

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

-(NSString *)logPrint {
    if ([[NSString stringWithContentsOfFile:[LOGGER_DIRECTORY stringByAppendingPathComponent:self.filename] encoding:NSUTF8StringEncoding error:NULL] length] != 0)
        return [NSString stringWithContentsOfFile:[LOGGER_DIRECTORY stringByAppendingPathComponent:self.filename] encoding:NSUTF8StringEncoding error:NULL];
    else return @"";
    
}

-(void)logDestory {
    [[NSFileManager defaultManager] removeItemAtPath:[LOGGER_DIRECTORY stringByAppendingPathComponent:self.filename] error:nil];

}

-(NSData *)logData {
    return [[NSFileManager defaultManager] contentsAtPath:[LOGGER_DIRECTORY stringByAppendingPathComponent:self.filename]];
    
}

-(NSURL *)logDirectory {
    return [NSURL fileURLWithPath:[LOGGER_DIRECTORY stringByAppendingPathComponent:self.filename]];
    
}

-(NSArray *)logFiles:(BOOL)directory {
    NSMutableArray *output = [[NSMutableArray alloc] init];
    for (NSString *files in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:LOGGER_DIRECTORY error:nil]) {
        if (directory) [output addObject:[NSURL URLWithString:[LOGGER_DIRECTORY stringByAppendingPathComponent:files]]];
        else [output addObject:files];
            
    }
                        
    return output;
    
}


@end
