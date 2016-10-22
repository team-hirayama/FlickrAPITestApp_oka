//
//  FASPhotoTableViewCell.m
//  FlickrAPISearch
//
//  Created by Oka Yuya on 2016/10/22.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

#import "FASPhotoTableViewCell.h"

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation FASPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setConfigure:(FASPhotoModel *)model {
    NSString *url = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", model.farm, model.server, model.photoId, model.secret];
    [self.flickrImageView setImageWithURL:[NSURL URLWithString:url]
                         placeholderImage:nil];
}

@end
