//
//  ViewController.m
//  CheckBox
//
//  Created by x.wang on 15/4/7.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import "ViewController.h"
#import "CheckBoxButton.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet CheckBoxButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.button addTaget:self action:@selector(buttonDown)];
    [self.button setTitle:@"hello world" forState:CheckBoxStateNormal];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.button.selected = YES;
//    self.button.font = [UIFont systemFontOfSize:10];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)buttonDown {
//    self.button.enable = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
