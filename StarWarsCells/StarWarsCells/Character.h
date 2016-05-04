//
//  Character.h
//  StarWarsCells
//
//  Created by Donny Davis on 5/4/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *shortDescription;
@property (nonatomic) NSString *species;
@property (nonatomic) NSString *affiliation;
@property (nonatomic) NSString *image;

+ (Character *)characterWithDictionary:(NSDictionary *)characterDictionary;

@end
