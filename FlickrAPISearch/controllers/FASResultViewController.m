//
//  FASResultViewController.m
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import "FASPhotoModel.h"
#import "FASPhotoTableViewCell.h"
#import "FASResultViewController.h"
#import "FASUsecase.h"


@interface FASResultViewController () <UITableViewDataSource, LoadPhotosUsecase>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) BOOL isGrid;
@property (nonatomic) NSArray<FASPhotoModel *> *dataSource;
@property (nonatomic) NSInteger pageNumber;

- (IBAction)switchAction:(id)sender;

@end

@implementation FASResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    FASUsecase *input = [FASUsecase new];
    input.usecase = self;
    self.dataSource = [NSArray array];
    self.pageNumber = 1;
    [input requestWithSearchWord:self.searchWord Page:self.pageNumber];
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)switchAction:(id)sender {
    self.isGrid = !self.isGrid;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isGrid) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FASPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                                  forIndexPath:indexPath];
    [cell setConfigure:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - LoadPhotosUsecase

- (void)loadPhotoWithData:(NSArray<FASPhotoModel *> *)dataSource {
    self.dataSource = dataSource;
    [self.tableView reloadData];
}

- (void)loadPhotoWithNoData {
    [self showNoDataAlert];
}

#pragma mark - Private method

- (void)showNoDataAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"該当する写真がありません。検索ワードを変更してお試しください。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
