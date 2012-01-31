//
//  Shot.h
//  TaT
//
//  Created by Tobias Friedenauer on 18.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shot : NSObject

@property (assign) int valveId;
@property (assign) int valveDelay;
@property (assign) int valveOpenTime;

+(id)shotWithValveId: (int) vi valveDelay: (int) vd valveOpenTime: (int) vo;

-(id)initWithValveId: (int) vi valveDelay: (int) vd valveOpenTime: (int) vo;

-(int)uebergabeWert;

@end
