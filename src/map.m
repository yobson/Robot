#import "map.h"

@implementation Map

-(id) init {
    if (self = [super init]) {
        mapWidth = 10;
        mapHeight = 10;
    }
    return self;
}

-(id) initWithWidth:(int) w andHeight:(int) h {
    if (self = [super init]) {
        mapWidth = w;
        mapHeight = h;
    }
    return self;
}

-(int) x:(int) x y:(int) y toIndex {
    return x + mapWidth * y;
}

-(void) index:(int) i toX:(int *) x andY:(int *)y {
    *x = index % mapWidth;
    *y = index / mapWidth;
}

@end