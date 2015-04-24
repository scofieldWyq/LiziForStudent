//
//  LiziLatest.m
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/21.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziLatest.h"
#import "LiziClassLatest.h"
#import "LiziCurses.h"
#import "LiziClass.h"

@implementation LiziLatest

+ (LiziLatest *)Latest{
    static LiziLatest *lizi_latest;
    
    if( !lizi_latest){
        lizi_latest = [[LiziLatest alloc] init];
        lizi_latest.latests = [[NSMutableArray alloc] init];
    }
    
    return lizi_latest;
}



- (void)latestTemplate{
    
    if([self.latests count] != 0)
        return ;
    
    LiziClassLatest *ll;
    [[LiziCurses getCurses] templation];
    
    for( LiziClass *c in [LiziCurses getCurses].curses ){
        ll = [[LiziClassLatest alloc] init];
        [ll setClassWithName:c.c_name title:@"hehe" time:[NSString stringWithFormat:@"%d:%d", rand()%24, rand()%60 + 1] number:[NSString stringWithFormat:@"%d", rand()%999]];
        [self.latests addObject:ll];
    }
}
@end
