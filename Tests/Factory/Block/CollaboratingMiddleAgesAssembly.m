////////////////////////////////////////////////////////////////////////////////
//
//  58 NORTH
//  Copyright 2013 58 North
//  All Rights Reserved.
//
//  NOTICE: This software is the proprietary information of 58 North
//  Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////

#import "CollaboratingMiddleAgesAssembly.h"
#import "MiddleAgesAssembly.h"
#import "TyphoonCollaboratingAssemblyProxy.h"
#import "TyphoonDefinition.h"
#import "Knight.h"
#import "OCLogTemplate.h"
#import "CampaignQuest.h"


@implementation CollaboratingMiddleAgesAssembly

- (void)resolveCollaboratingAssemblies
{
    [self setQuests:[TyphoonCollaboratingAssemblyProxy proxy]];
}

- (id)knightWithExternalQuest
{
    return [TyphoonDefinition withClass:[Knight class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(quest) withDefinition:[_quests environmentDependentQuest]];
    }];
}

+ (void)verifyKnightWithExternalQuest:(Knight*)knight
{
    LogTrace(@"Knight: %@", knight);

    if (!knight) {
        [NSException raise:NSInternalInconsistencyException format:@"Expected a non-nil knight, but got nil."];
    }
//    assertThat(knight, notNilValue()); // this needs to call into a SenTestCase, not being self. Perhaps provide when initializing the assembly, and then add a new macro to OCHamcrest?

    if (![knight.quest isKindOfClass:[CampaignQuest class]]) {
        [NSException raise:NSInternalInconsistencyException format:@"Expected a campaign quest to be provided to the knight, but was '%@'", knight.quest];
    }
    //assertThat(knight.quest, instanceOf([CampaignQuest class]));
}

@end