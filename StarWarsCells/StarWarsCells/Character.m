//
//  Character.m
//  StarWarsCells
//
//  Created by Donny Davis on 5/4/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "Character.h"

@implementation Character

+ (Character *)characterWithDictionary:(NSDictionary *)characterDictionary {
    Character *aCharacter = nil;
    if (characterDictionary) {
        aCharacter = [[Character alloc] init];
        aCharacter.name = characterDictionary[@"name"];
        aCharacter.shortDescription = characterDictionary[@"description"];
        aCharacter.species = characterDictionary[@"species"];
        aCharacter.affiliation = characterDictionary[@"affiliation"];
        aCharacter.image = characterDictionary[@"image"];
    }
    
    return aCharacter;
}

@end
