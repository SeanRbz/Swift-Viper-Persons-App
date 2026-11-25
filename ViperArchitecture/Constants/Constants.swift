//
//  Constants.swift
//  ViperArchitecture
//
//  Created by Sean Rubio on 11/25/26.
//

import CoreGraphics

/// 4/8pt spacing scale (ui-ux-pro-max: section tiers 16/24/32/48).
enum Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    /// Keeps cards a readable width on iPad / landscape.
    static let maxContentWidth: CGFloat = 600
}

/// Default content of `CardView` (Views/Components). Override per call site if needed.
let SHOW_CARD_IMAGE: Bool = true
let SHOW_CARD_TITLE: Bool = true

let USERS_TITLE: String = "Users"
let USER_DETAILS_TITLE: String = "User Details"
let PHOTOS_TITLE: String = "Photos"
let RECENT_POSTS_TITLE: String = "Recent Posts"
let VIEW_COMMENTS_TITLE: String = "View Comments"
let BASE_URL: String = "https://jsonplaceholder.typicode.com"
