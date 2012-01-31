//
//  Shot.m
//  TaT
//
//  Created by Tobias Friedenauer on 18.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Shot.h"

@implementation Shot
@synthesize valveId;
@synthesize valveDelay;
@synthesize valveOpenTime;


-(id)initWithValveId: (int) vi valveDelay: (int) vd valveOpenTime: (int) vo
{
    
    self = [super init];
    if(self){
        valveId = vi;
        valveDelay = vd;
        valveOpenTime = vo;
        
    }
    
    return self;
}

+(id)shotWithValveId: (int) vi valveDelay: (int) vd valveOpenTime: (int) vo
{
    return[[Shot alloc] initWithValveId: (int) vi valveDelay: (int) vd valveOpenTime: (int) vo];
    NSLog(@"Es wird Ventil%i %ims lang ausgelöst. Nach %ims gehts weiter.", vi, vo, vd);
}



-(int)uebergabeWert
{
    NSLog(@"%i/%i/%i", valveId, valveDelay, valveOpenTime);
    return 1;    
    
}



@end
