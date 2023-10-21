import UIKit

protocol FeedLoader {
    func loadFeed(complition: @escaping ([String]) -> Void)
}

struct Reachability {
    static let networkAvailable = false
}

class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        loader.loadFeed { loaditem in
            
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(complition: @escaping ([String]) -> Void) {
        //do something
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(complition: @escaping ([String]) -> Void) {
        //do something
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
