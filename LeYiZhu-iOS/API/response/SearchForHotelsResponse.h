//
//  SearchForHotelsResponse.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseSearchResultModel.h"


@interface SearchForHotelsResponse : AbstractResponse

@property(nonatomic, readonly, strong) BaseSearchResultModel * baseSearchResult;



@end
