import UIKit

protocol FeedLoader {
    func loadFeed(complition: @escaping ([String]) -> Void)
}

struct Reachability {
    static let networkAvailable = true
}

class FeedViewController {
    var loader: FeedLoader!
    
    init(loader: FeedLoader) {
        self.loader = loader
    }
    
    func viewDidLoad() {
        loader.loadFeed { loaditem in
            print(loaditem)
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(complition: @escaping ([String]) -> Void) {
        //do something
        complition(["RemoteFeedLoader"])
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(complition: @escaping ([String]) -> Void) {
        //do something
        complition(["LocalFeedLoader"])
    }
}

class RemoteWithLocalallBackFeedLoader: FeedLoader {
    let remoteFeedLoader: RemoteFeedLoader
    let localFeedLoader: LocalFeedLoader

    init(remoteFeedLoader: RemoteFeedLoader, localFeedLoader: LocalFeedLoader) {
        self.remoteFeedLoader = remoteFeedLoader
        self.localFeedLoader = localFeedLoader
    }
    
    func loadFeed(complition: @escaping ([String]) -> Void) {
        let load = Reachability.networkAvailable ? remoteFeedLoader.loadFeed : localFeedLoader.loadFeed
        load(complition)
    }
}

let v1 = FeedViewController.init(loader: RemoteFeedLoader())
v1.viewDidLoad()
let v2 = FeedViewController.init(loader: LocalFeedLoader())
v2.viewDidLoad()
let v3 = FeedViewController.init(loader: RemoteWithLocalallBackFeedLoader(remoteFeedLoader: RemoteFeedLoader(), localFeedLoader: LocalFeedLoader()))
v3.viewDidLoad()

//["RemoteFeedLoader"]
//["LocalFeedLoader"]
//["RemoteFeedLoader"]
