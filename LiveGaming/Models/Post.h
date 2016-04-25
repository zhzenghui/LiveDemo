//
//  Posts.h
//  CooLaDingNOTwo
//
//  Created by xy on 15/12/22.
//  Copyright © 2015年 coolading. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kAll = nil;
static NSString *const kText = @"text";
static NSString *const kChat = @"chat";
static NSString *const kLink = @"link";
static NSString *const kPhoto = @"photo";
static NSString *const kAudio = @"audio";
static NSString *const kVideo = @"video";




@class Reblog;
@class Trail,Theme;
@class Post;
@class Alt_Size;
@class Photo;
@class Original_Size;
@class Blog;
@class Note;
@interface Post : NSObject




@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *recommended_color;

@property (nonatomic, assign) BOOL liked;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *recommended_source;

@property (nonatomic, assign) BOOL followed;

@property (nonatomic, copy) NSString *blog_name;

@property (nonatomic, copy) NSString *short_url;

@property (nonatomic, strong) NSArray *highlighted;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *video_type;


@property (nonatomic, copy) NSString *post_url;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *format;

@property (nonatomic, copy) NSString *caption;

@property (nonatomic, assign) NSInteger timestamp;

@property (nonatomic, assign) NSInteger note_count;

@property (nonatomic, copy) NSString *reblog_key;

@property (nonatomic, assign) BOOL bookmarklet;


@property (nonatomic, strong) NSDictionary *reblog;


@property (nonatomic, assign) NSInteger thumbnail_height;

@property (nonatomic, copy) NSString *thumbnail_url;

@property (nonatomic, assign) BOOL html5_capable;

@property (nonatomic, assign) NSInteger thumbnail_width;

@property (nonatomic, copy) NSString *video_url;

@property (nonatomic, assign) NSInteger duration;



@property (nonatomic, copy) NSString *reblogged_from_title;

@property (nonatomic, copy) NSString *reblogged_from_name;

@property (nonatomic, copy) NSString *reblogged_root_id;

@property (nonatomic, assign) BOOL reblogged_from_can_message;

@property (nonatomic, copy) NSString *reblogged_root_url;

@property (nonatomic, copy) NSString *reblogged_root_title;

@property (nonatomic, copy) NSString *reblogged_from_id;

@property (nonatomic, copy) NSString *reblogged_root_uuid;

@property (nonatomic, assign) BOOL reblogged_root_following;

@property (nonatomic, copy) NSString *reblogged_from_url;

@property (nonatomic, assign) BOOL reblogged_from_following;

@property (nonatomic, copy) NSString *reblogged_from_uuid;

@property (nonatomic, copy) NSString *reblogged_root_name;

@property (nonatomic, assign) BOOL reblogged_root_can_message;

@property (nonatomic, assign) BOOL can_send_in_message;

@property (nonatomic, copy) NSString *source_title;

@property (nonatomic, copy) NSString *source_url;

@property (nonatomic, strong) Post *post;


@property (nonatomic, copy) NSString *image_permalink;



@property (nonatomic, strong) NSArray *trail;


@property (nonatomic, strong) NSArray *photos;


@property (nonatomic, strong) NSArray *player;

//@property (nonatomic, strong) NSArray *notes;
@property (nonatomic, strong) NSArray<Note *> *notes;




@end




@interface Player : NSObject


@property (nonatomic, assign) NSInteger width;

@property (nonatomic, copy) NSString *embed_code;


@end

@interface Reblog : NSObject

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *tree_html;

@end


@interface Photo : NSObject


@property (nonatomic, assign) BOOL can_reply;

@property (nonatomic, copy) NSString *caption;

@property (nonatomic, strong) NSArray *alt_sizes;

@property (nonatomic, strong) Original_Size *original_size;


@property (nonatomic, assign) BOOL can_send_in_message;

@end




@interface Trail : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Theme *theme;

@property (nonatomic, assign) BOOL active;

@property (nonatomic, strong) Post *post;


@property (nonatomic, copy) NSString *content_raw;

@property (nonatomic, assign) BOOL is_root_item;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) BOOL is_current_item;


@end

@interface Theme : NSObject

@property (nonatomic, assign) BOOL show_avatar;

@property (nonatomic, assign) BOOL header_stretch;

@property (nonatomic, copy) NSString *header_image_focused;

@property (nonatomic, copy) NSString *background_color;

@property (nonatomic, copy) NSString *header_bounds;

@property (nonatomic, assign) BOOL show_title;

@property (nonatomic, copy) NSString *link_color;

@property (nonatomic, copy) NSString *avatar_shape;

@property (nonatomic, copy) NSString *header_image_scaled;

@property (nonatomic, assign) BOOL show_header_image;

@property (nonatomic, copy) NSString *title_color;

@property (nonatomic, copy) NSString *header_image;

@property (nonatomic, copy) NSString *body_font;

@property (nonatomic, assign) BOOL show_description;

@property (nonatomic, copy) NSString *title_font;

@property (nonatomic, copy) NSString *title_font_weight;

@end




@interface Alt_Size : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

@interface Original_Size : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;


@property (nonatomic, strong) Blog *blog;


@end



@interface Blog : NSObject

@property (nonatomic, copy) NSString *facebook_opengraph_enabled;

@property (nonatomic, assign) BOOL twitter_enabled;

@property (nonatomic, assign) BOOL primary;

@property (nonatomic, assign) BOOL is_blocked_from_primary;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL ask;

@property (nonatomic, assign) NSInteger likes;

@property (nonatomic, assign) NSInteger messages;

@property (nonatomic, assign) NSInteger drafts;

@property (nonatomic, assign) BOOL followed;

@property (nonatomic, copy) NSString *facebook;

@property (nonatomic, copy) NSString *ask_page_title;

@property (nonatomic, assign) BOOL ask_anon;

@property (nonatomic, assign) BOOL twitter_send;

@property (nonatomic, assign) NSInteger updated;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *tweet;

@property (nonatomic, assign) BOOL admin;

@property (nonatomic, assign) BOOL share_likes;

@property (nonatomic, assign) NSInteger followers;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) BOOL subscribed;

@property (nonatomic, assign) NSInteger posts;

@property (nonatomic, assign) BOOL is_nsfw;

@property (nonatomic, assign) BOOL can_send_fan_mail;

@property (nonatomic, assign) NSInteger queue;

@property (nonatomic, assign) BOOL can_subscribe;

//@property (nonatomic, copy) NSString *description;




@end

@interface Note : NSObject

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *blog_name;

@property (nonatomic, copy) NSString *blog_uuid;

@property (nonatomic, copy) NSString *post_id;

@property (nonatomic, copy) NSString *blog_url;

@end

