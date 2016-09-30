//
//  SelectCountryViewController.h
//  Floral
//
//  Created by 思 彭 on 16/9/9.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^didSelectedCountry)(NSString *selectCountry);

@interface SelectCountryViewController : BaseViewController

@property (nonatomic,copy) didSelectedCountry selectCountryblock; /*<#id#>*/

@end
