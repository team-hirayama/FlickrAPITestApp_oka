//
//  ViewController.m
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import "FASResultViewController.h"
#import "FASSearchViewController.h"

#import "Reachability.h"

@interface FASSearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (weak, nonatomic) Reachability *reachability;

- (IBAction)executeSearch:(id)sender;

@end

@implementation FASSearchViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.inputTextField.delegate = self;
    self.searchButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)dealloc {
    [self.reachability stopNotifier];
}

#pragma mark - IBAction

- (IBAction)executeSearch:(id)sender {
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    switch ([self getNetworkStatus]) {
        case ReachableViaWWAN:
        case ReachableViaWiFi:
            [self goSearch];
            break;
        case NotReachable:
            [self showOfflineAlert];
            break;
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger textLength = (textField.text.length - range.length) + string.length;
    
    if (textLength) {
        self.searchButton.enabled = YES;
    } else {
        self.searchButton.enabled = NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- Private method

- (NetworkStatus)getNetworkStatus {
    return [self.reachability currentReachabilityStatus];
}

- (void)showOfflineAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"ネットワーク環境の良い環境で再度お試しください。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) wself = self;
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [wself.inputTextField becomeFirstResponder];
                                                   }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)goSearch {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FASResult"
                                                         bundle:nil];
    FASResultViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"FASResultViewController"];
    
    controller.searchWord = self.inputTextField.text;

    [self.navigationController pushViewController:controller animated:YES];
}

@end
