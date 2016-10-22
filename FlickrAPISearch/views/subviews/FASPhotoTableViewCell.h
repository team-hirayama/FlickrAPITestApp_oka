//
//  FASPhotoTableViewCell.h
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FASPhotoModel.h"

@interface FASPhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flickrImageView;

- (void)setConfigure:(FASPhotoModel *)model;

@end
