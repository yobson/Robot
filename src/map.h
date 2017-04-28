#import <ObjFW/OFObject.h>

@interface Map : OFObject {
    int mapWidth;
    int mapHeight;
}

-(id) init;
-(id) initWithWidth:(int) w andHeight:(int) h;
-(int) x:(int) x y:(int) y toIndex;
-(void) index:(int) i toX:(int *) x andY:(int *)y;

@end