//
//  ViewController.m
//  test
//
//  Created by qianfeng on 14-5-23.
//  Copyright (c) 2014年 唐波. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.frame = CGRectMake(10, 100, 100, 60);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
    [queue addOperation:operation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printTest:) name:@"runloop" object:nil];
}

- (void)printTest:(NSNotification *)n
{
    static int a = 0;
    a ++;
    NSLog(@"aaa");
    NSLog(@"%d", a);
}

- (void)threadRun
{
    while (1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"runloop" object:nil];
        sleep(1);
    }
}

- (void)btnClick:(UIButton *)btn
{
    NSLog(@"aaaaaaaaaaa");
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.userInteractionEnabled = NO;
    [btn removeTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)produceCategoryData
{
    NSDictionary *dict1 = @{@"category_cname": @"全\n部", @"category_id": @"1123592"};
    NSDictionary *dict2 = @{@"category_cname": @"书籍", @"category_id": @"6018"};
    NSArray *array = @[dict1, dict2];
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *jarray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 100)];
    label.text = jarray[0][@"category_cname"];
    label.numberOfLines = 0;
    [label setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:label];
    NSLog(@"aaaaaaaa\nbbbb");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
