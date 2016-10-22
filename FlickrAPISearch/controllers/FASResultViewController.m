//
//  FASResultViewController.m
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import "FASResultViewController.h"

@interface FASResultViewController ()

@end

static NSString *const FASApiKey = @"10ba93bbe49a6480d765ce486673954a";

@implementation FASResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.searchWord);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
