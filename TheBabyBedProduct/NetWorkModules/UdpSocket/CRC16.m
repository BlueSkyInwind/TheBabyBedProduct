//
//  CRC16.m
//  BraHolter
//
//  Created by Mac on 9/8/15.
//  Copyright (c) 2015 Wangyongxin. All rights reserved.
//

#import "CRC16.h"

@implementation CRC16


-(id)initWithValue:(int)aValue{
    self = [super init];
    
    if (self != nil) {
        
        value = 0;
    }
    
    return self;

}

-(void)update:(int)aByte{
    value = value ^ (aByte << 8);
    for (int i = 0; i < 8; i++) { /* Prepare to rotate 8 bits */
        
        if ((value & 0x8000) != 0) { /* b15 is set... */
            value = (value << 1) ^ 0x1021; /* rotate and XOR with polynomic */
        } else { /* b15 is clear... */
            value <<= 1; /* just rotate */
        }
    }
    value = value & 0xffff;
    return;
}

-(void)reset{
    value = 0;
}
-(int)getValue{
    return value;
}
-(uint8_t)getByte1{
    return (value & 0xFF);
}
-(uint8_t)getByte2{
    return (value >> 8);
}


@end
