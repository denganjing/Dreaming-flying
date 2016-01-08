//
//  MainViewCell.m
//  TheGoodNight
//
//  Created by imac on 15/10/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainViewCell.h"
#import "MainModel.h"

@implementation MainViewCell{

    __weak IBOutlet UIImageView *bgimage;
    
    __weak IBOutlet UILabel *NSTitle;
    
    __weak IBOutlet UILabel *NSpoi;
    
    __weak IBOutlet UILabel *NSdistance;
    
    __weak IBOutlet UILabel *NSCategory;
    
    __weak IBOutlet UILabel *NStimeDesc;
    
    __weak IBOutlet UILabel *NScollectedNum;
    
    __weak IBOutlet UILabel *NSPrice;
}
//手写代码构造
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType =UITableViewCellAccessoryDetailButton;
    }
    return self;
}

-(void)configureCellWithModel:(MainModel*)model{
    NSTitle.text =model.title;
    NStimeDesc.text =model.timeDesc;
    NSpoi.text =model.poi;
    NSdistance.text =[NSString stringWithFormat:@"%@m",model.distance ];
    NScollectedNum.text =[NSString stringWithFormat:@"%@人收藏",model.collectedNum ];
    NSPrice.text =[NSString stringWithFormat:@"%@¥",model.price];
    NSCategory.text =model.category;
//    [bgimage sd_setImageWithURL:[NSURL URLWithString:model.frontCoverImageList]];
    [bgimage sd_setImageWithURL:[NSURL URLWithString:model.frontCoverImageList] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      //  NSLog(@"%@",image);
    }];
   // NSLog(@"%@",bgimage);

}




@end
