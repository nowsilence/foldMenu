/*
 *	zFirstController.h
 * 	FoldTransition
 *
 * 	Created by zhu yangyong on 13-7-31.
 *    Copyright (c) 2013年 nowsilence. All rights reserved.
 *
 */


#import <UIKit/UIKit.h>
@protocol SecDelegate;
@interface zSecController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    id<SecDelegate> delegate;
}
@property(nonatomic,weak) id<SecDelegate> delegate;
- (void) show:(int)topS;
- (void) open;
@end
@protocol SecDelegate <NSObject>

- (void) close;
- (void) open;
- (BOOL) isOpened;

@end