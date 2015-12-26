//
//  JokeCellTableViewCell.m
//  MCJRescom
//
//  Created by MCJ on 15/12/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JokeCellTableViewCell.h"
#import "AppSetting.h"

@interface JokeCellTableViewCell ()
{
    BOOL _isMenuColor;
}
@end

@implementation JokeCellTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onJokeColorChange) name:@"YCHANGECOLOR" object:nil];
    }
    return self;
}

-(void)setInfo:(JokeModel*)model isMenuColor:(BOOL)isMenuColor{
    _isMenuColor = isMenuColor;
    self.textLabel.text = model.title;
    self.textLabel.font = [UIFont systemFontOfSize:20];
    
    self.detailTextLabel.text = [NSString stringWithFormat:@"\n%@",[model.content stringByReplacingOccurrencesOfString:@"<br/><br/>" withString:@"\n"]];
    self.detailTextLabel.font = [UIFont systemFontOfSize:15];
    self.detailTextLabel.numberOfLines = 0;
    
    [self.detailTextLabel sizeToFit];
    
    if (_isMenuColor) {
        self.backgroundColor = [AppSetting menuColorWithAlpha:0.5];
        self.textLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [AppSetting bgColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.textColor = [UIColor blackColor];
    }
}

-(void)onJokeColorChange{
    [UIView animateWithDuration:0.5 animations:^{
        NSLog(@"_isMenuColor = %d",_isMenuColor);
        if (_isMenuColor) {
            self.backgroundColor = [AppSetting menuColorWithAlpha:0.5];
        }else{
            self.backgroundColor = [AppSetting bgColor];
        }
    }];
    
}

@end
