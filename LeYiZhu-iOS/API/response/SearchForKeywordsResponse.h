//
//  SearchForKeywordsResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseSearchForKeywordsModel.h"

@interface SearchForKeywordsResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseSearchForKeywordsModel *searchForKeyModel;



@end
