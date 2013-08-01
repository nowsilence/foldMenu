/*
 *  zFirstController.m
 *  FoldTransition
 *
 *  Created by zhu yangyong on 13-7-31.
 *  Copyright (c) 2013年 nowsilence. All rights reserved.
 *
 */

#import "zFirstController.h"
#import "UIView+Origami.h"

@interface zFirstController ()
{
    UINavigationController *navC;
    UIViewController *vc;
    UITableView *mTableview;
    zSecController *sec;
    
    BOOL isLeftOpened;
}
@end

@implementation zFirstController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    self.view.backgroundColor = [UIColor grayColor];
    
    isLeftOpened = YES;
    
    
    sec = [[zSecController alloc] init];
    sec.delegate = self;
    mTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, 480) style:UITableViewStylePlain];
    
    sec.view.frame = CGRectMake(0, 0, 320, 480);
    mTableview.backgroundColor = [UIColor redColor];
    mTableview.dataSource = self;
    mTableview.delegate = self;
    mTableview.frame = CGRectMake(0, 0, 140, 480);
//    [self.view addSubview:mTableview];
    [self.view addSubview:sec.view];
    
//    mTableview.alpha = .5f;
    [sec.view showOrigamiTransitionWith:mTableview level:0 NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
        isLeftOpened = YES;
    }];
	// Do any additional setup after loading the view.
}

- (void) close
{
    [sec.view hideOrigamiTransitionWith:mTableview level:0 NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
        isLeftOpened = NO;
    }];
}

- (BOOL) isOpened
{
    return isLeftOpened;
}

- (void) open
{
    [sec.view showOrigamiTransitionWith:mTableview level:0 NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
        isLeftOpened = YES;
        [sec open];
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"1";
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [sec show:indexPath.row];
//    if (tableView == self.FirstLevelView)
//    {
//        //        [navC.view showOrigamiTransitionWith:self.SecLevelView NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
//        //
//        //        }] ;
//        
//        [navC.view showOrigamiTransitionWith:self.SecLevelView NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
//            
//        }] ;
//        //        self.view
//    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
