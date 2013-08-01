/*
 *  zFirstController.m
 *  FoldTransition
 *
 *  Created by zhu yangyong on 13-7-31.
 *  Copyright (c) 2013年 nowsilence. All rights reserved.
 *
 */

#import "zSecController.h"
#import "UIView+Origami.h"

@interface zSecController ()
{
    UINavigationController *navC;
    UIViewController *vc;
    UITableView *mTableview;
    
    BOOL isLeftOpened;
    int topSelect;
}
@end

@implementation zSecController
@synthesize delegate;
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
    topSelect = -1;
    
//    isLeftOpened = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 40);
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"dd" forState:UIControlStateNormal];
    vc = [[UIViewController alloc] init];
    self.view.backgroundColor = [UIColor blueColor];
//    vc.view.frame = CGRectMake(0, 0, 320, 480);
    navC = [[UINavigationController alloc] initWithRootViewController:vc];
    navC.view.frame = CGRectMake(0, 0, 320, 480);
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    vc.view.backgroundColor = [UIColor redColor];
    //    vc.view.frame = CGRectMake(140, 0, 280, 480);
    
    mTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, 480) style:UITableViewStylePlain];
    mTableview.backgroundColor = [UIColor orangeColor];
    mTableview.dataSource = self;
    mTableview.delegate = self;
    
    
    [self.view addSubview:navC.view];
}

- (void) show:(int)topS
{
    if (topS != topSelect)
    {
        NSLog(@"111");
        topSelect = topS;
        if (!isLeftOpened)
        {
            [navC.view showOrigamiTransitionWith:mTableview level:1 NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
                isLeftOpened = !isLeftOpened;
            }];
        }
        else
        {
            [navC.view hideOrigamiTransitionWith:mTableview level:1 NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
                isLeftOpened = !isLeftOpened;
                [navC.view showOrigamiTransitionWith:mTableview level:1 NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
                    isLeftOpened = !isLeftOpened;
                }];
            }];
        }
        
    }    
}

- (void) open
{
    [navC.view showOrigamiTransitionWith:mTableview level:1 NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
        isLeftOpened = !isLeftOpened;
    }];
}

- (void) btnClicked
{
   
    if (isLeftOpened)
    {
    
        [navC.view hideOrigamiTransitionWith:mTableview level:1 NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
            isLeftOpened = !isLeftOpened;
            
            [delegate close];
        }];
    }
    else
    {
        if ([delegate isOpened]) {
            [delegate close];
        }
        else 
        [delegate open];
        NSLog(@"====");
        
    }
 
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
    cell.textLabel.text = @"2";
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [navC.view hideOrigamiTransitionWith:mTableview NumberOfFolds:1 Duration:.35f Direction:XYOrigamiDirectionFromLeft completion:^(BOOL finished) {
//        isLeftOpened = !isLeftOpened;
//    }];
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
