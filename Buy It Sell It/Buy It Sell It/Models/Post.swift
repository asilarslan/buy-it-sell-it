//
//  Post.swift
//  Facebook+Research
//
//  Created by Duc Tran on 3/20/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

struct Post
{
    var id: Int?
    var createdBy: User
    var location: String?
    var description: String?
    var image: UIImage?
    var price: Double?
    var numberOfComments: Int?
    var numberOfShares: Int?
    
//    static func fetchPosts() -> [Post]
//    {
//        var posts = [Post]()
//        
//        let duc = User(username: "Duc Tran", profileImage: UIImage(named: "duc"))
//        let post1 = Post(createdBy: duc, location: "1 hr", description: "Wise words from Will Smith: The only thing that I see that is distinctly different from me is: I'm not afraid to die on a treadmill. I will not be outworked, period. You might have more talent than me, you might be smarter than me, you might be sexier than me. You might be all of those things. You got it on me in nine categories. But if we get on the treadmill together, there's two things. You're getting off first, or I'm going to die. It's really that simple. Love that. I wish that you'll embrace this mindset in everything that you do. Tonight, when you think about 2017, don't set resolutions but set goals. Trust in your abilities to figure things out. No matter how small you start, start something that matters. With enough time, focus, effort, even resources and mentorship, you will develop new skills and achieve your goals.", image: UIImage(named: "1"), price: 12, numberOfComments: 32, numberOfShares: 28)
//        let post2 = Post(createdBy: duc, location: "3 hrs", description: "When you work on any thing that matters, it's ok to worry, fear, and be uncomfortable. Just never give up!", image: UIImage(named: "2"), price: 8, numberOfComments: 12, numberOfShares: 92)
//        let post3 = Post(createdBy: duc, location: "5 hrs", description: "New iOS tutorial is up for developers out in the world: JoinDuc.com/iosapp-fb", image: UIImage(named: "3"), price: 8, numberOfComments: 92, numberOfShares: 89)
//        
//        let brendon = User(username: "Brendon Burchard", profileImage: UIImage(named: "brendon"))
//        let post4 = Post(createdBy: brendon, location: "2 hrs", description: "You are not selfish for desiring a better life. If you appreciate what you have but feel called to the next level, that's something to listen to.", image: UIImage(named: "4"), price: 94, numberOfComments: 8, numberOfShares: 918)
//        let post5 = Post(createdBy: brendon, location: "8 hrs", description: "No matter how small you start, start something that matters. Believe in your dreams and begin.", image: UIImage(named: "5"), price: 99, numberOfComments: 83, numberOfShares: 89)
//        let post6 = Post(createdBy: brendon, location: "Yesterday", description: "Congratulations to the graduating class of high performance academy 2017! Thank you for your engagement, joy and confidence. Now go serve the world!", image: UIImage(named: "6"), price: 9, numberOfComments: 82, numberOfShares: 74)
//        
//        posts.append(post1)
//        posts.append(post4)
//        posts.append(post2)
//        posts.append(post5)
//        posts.append(post3)
//        posts.append(post6)
//        
//        return posts
//    }
}

class User
{
    var username: String!
    var profileImageUrl: String!
    var profileImage: UIImage!
    
    init(username: String,profileImage: UIImage) {
        self.username=username
        self.profileImage=profileImage
    }
    init(username: String,profileImageUrl: String) {
        self.username=username
        self.profileImageUrl=profileImageUrl
    }
}













