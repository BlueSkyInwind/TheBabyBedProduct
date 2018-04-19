//
//  CRC16.h
//  BraHolter
//
//  Created by Mac on 9/8/15.
//  Copyright (c) 2015 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRC16 : NSObject{
int value;

}

-(id)initWithValue:(int)aValue;

-(void)update:(int)aByte;
-(void)reset;
-(int)getValue;
-(uint8_t)getByte1;
-(uint8_t)getByte2;

@end
