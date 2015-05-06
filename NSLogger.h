//
//  NSLogger.h
//  Video Downloader
//
//  Created by Joe Barbour on 21/04/2015.
//  Copyright (c) 2015 NorthernSpark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSLogger : NSObject {
}

-(void)log:(NSString *)title properties:(NSDictionary *)properties error:(BOOL)error;

-(NSURL *)logDirectory;
-(NSString *)logPrint;
-(NSData *)logData;

@property (nonatomic) BOOL degbugger;

@end
