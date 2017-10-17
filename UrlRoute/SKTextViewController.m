//
//  SKTextViewController.m
//  UrlRoute
//
//  Created by lon on 2017/10/13.
//  Copyright © 2017年 lon. All rights reserved.
//

#import "SKTextViewController.h"
#import "SKUrlRoute.h"
#import "ViewController.h"
@interface SKTextViewController ()
@property(nonatomic,copy)NSString *valueStr;

@end

@implementation SKTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    self.navigationItem.leftBarButtonItem = item;


    if (self.valueStr) {
        UILabel *label = [[UILabel alloc]init];
        [label setText:self.valueStr];
        [label setFont:[UIFont systemFontOfSize:32]];
        [label sizeToFit];
        label.center = self.view.center;
        [self.view addSubview:label];
    }
    [SKUrlRouteCenter goToVC:[ViewController new] animated:YES URLRedirectType:kUrlRedirectPush];

    // Do any additional setup after loading the view.
}
-(void)back {


    if (self.routeReCallBlock) {
        self.routeReCallBlock(@"faas");
    }
    [SKUrlRouteCenter closeWithAnimated:YES];


}
- (void)dealloc{
    NSLog(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
