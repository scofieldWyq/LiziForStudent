//
//  LiziCurses.m
//  LiziForStudent
//
//  Created by 吴英强 on 15/4/21.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "LiziCurses.h"
#import "LiziClass.h"

@implementation LiziCurses

-(instancetype)init{
    self = [super init];
    
    if(self)
    {
        self.curses = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (LiziCurses *)getCurses {
    static LiziCurses *myCurses;
    
    if(! myCurses){
        myCurses = [[LiziCurses alloc] init];
    }
    
    return myCurses;
}

- (void)templation {
    
    /* class */
    LiziClass *tmpClass;
    
    tmpClass = [[LiziClass alloc] initWithName:@"高数" Info:@"数学是研究现实世界数量关系和空间形式的学科.随着现代科学技术和数学科学的发展，“数量关系”和“空间形式”有了越来越丰富的内涵和更加广泛的外延" Teacher:@"周华" ID:@"00001"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"概率论" Info:@"概率论是研究随机现象数量规律的数学分支。随机现象是相对于决定性现象而言的。在一定条件下必然发生某一结果的现象称为决定性现象。" Teacher:@"叶军" ID:@"00002"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"体育" Info:@"体育（physical education，缩写PE或P.E.），是一种复杂的社会文化现象，它以身体与智力活动为基本手段，根据人体生长发育、技能形成和机能提高等规律，达到促进全面发育、提高身体素质与全面教育水平、增强体质与提高运动能力、改善生活方式与提高生活质量的一种有意识、有目的、有组织的社会活动。" Teacher:@"郭小军" ID:@"00003"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"模拟电路" Info:@"模拟电路（Analog Circuit）：处理模拟信号的电子电路 。“模拟”二字主要指电压（或电流）对于真实信号成比例的再现，它最初来源于希腊语词汇ανάλογος，意思是“成比例的”。" Teacher:@"郭小军" ID:@"00004"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"c语言程序设计" Info:@"C语言是一种计算机程序设计语言。它既有高级语言的特点，又具有汇编语言的特点。它可以作为系统设计语言，编写工作系统应用程序，也可以作为应用程序设计语言，编写不依赖计算机硬件的应用程序。因此，它的应用范围广泛。" Teacher:@"刘林峰" ID:@"00005"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"算法与数据结构" Info:@"基本概念、简单数据结构（线性表、栈、队列）、复杂数据结构（树、图）和算法与数据结构应用（排序、查找、算法设计基础）四部分，详细介绍了常用数据结构和算法的基本概念及其不同的实现方法，对各种数据结构，讨论了在不同存储结构上实现线性和非线性结构的不同运算，并对算法设计的方法和技巧进行了介绍。" Teacher:@"刘林峰" ID:@"00006"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"数值分析" Info:@"数值分析(numerical analysis)是研究分析用计算机求解数学计算问题的数值计算方法及其理论的学科，是数学的一个分支，它以数字计算机求解数学问题的理论和方法为研究对象。为计算数学的主体部分。" Teacher:@"炎针针" ID:@"00007"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"计算机网络" Info:@"计算机网络，是指将地理位置不同的具有独立功能的多台计算机及其外部设备，通过通信线路连接起来，在网络操作系统，网络管理软件及网络通信协议的管理和协调下，实现资源共享和信息传递的计算机系统。" Teacher:@"江中略" ID:@"00008"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"android开发" Info:@"Android是一种基于Linux的自由及开放源代码的操作系统，主要使用于移动设备，如智能手机和平板电脑，由Google公司和开放手机联盟领导及开发。" Teacher:@"徐磊" ID:@"00009"];
    
    [self.curses addObject:tmpClass];
    
    tmpClass = [[LiziClass alloc] initWithName:@"分布式系统" Info:@"分布式系统（distributed system）是建立在网络之上的软件系统。正是因为软件的特性，所以分布式系统具有高度的内聚性和透明性。" Teacher:@"丁宇轩" ID:@"00010"];
    
    [self.curses addObject:tmpClass];
    
}
@end
