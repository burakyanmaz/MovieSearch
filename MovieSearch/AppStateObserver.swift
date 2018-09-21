//
//  AppStateObserver.swift
//  MovieSearch
//
//  Created by NDSDEVTEAM9 on 21.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit

protocol Observer: class {
    //func update<T>(with newValue: T)
    func searchHappened(with keywords: String)
    func searchResultFetched()
}
extension Observer {
    func searchHappened(with keywords: String) {}
    func searchResultFetched() {}
}

class AppStateObserver {
    fileprivate var observations = [ObjectIdentifier : Observation]()
    
    fileprivate var searchState = SearchState.idle {
        // We add a property observer on 'state', which lets us
        // run a function on each value change.
        didSet { searchStateDidChange() }
    }
    
    static let sharedInstance = AppStateObserver()
    
    private init() {}
    
    // MARK: - App Search State
    func startASearch(with keywords: String) {
        searchState = .searchStart(with: keywords)
    }
    func searchDidComplete() {
        searchState = .searchResultFetchedFromWebAPI
    }
}

extension AppStateObserver {
    enum SearchState {
        case searchStart(with: String)
        case searchResultFetchedFromWebAPI
        case idle
    }
}

/**
 A good practice to only keep weak references to all observers. Otherwise, it's easy to introduce retain cycles when the owner of an observed object is also an observer itself.
 However, storing objects weakly in a Swift collection in a nice way is not always straight forward, since by default all collections retain their members strongly.
 
 To solve this problem for our observation needs, we're going to introduce a small wrapper type, that simply keeps track of an observer with a weak reference.
 */
private extension AppStateObserver {
    struct Observation {
        weak var observer: Observer?
    }
}

private extension AppStateObserver {
    private func cleanObserversIfNecessary(changeARelevantState: (_ observer: Observer) -> Void) {
        for (id, observation) in observations {
            // If the observer is no longer in memory, we
            // can clean up the observation for its ID
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
            }
            
            changeARelevantState(observer)
        }
    }
    
    func searchStateDidChange() {
        cleanObserversIfNecessary(changeARelevantState: { observer in
            switch searchState {
            case .searchStart(let keywords):
                // Broadcast the search state
                observer.searchHappened(with: keywords)
                
            case .searchResultFetchedFromWebAPI:
                observer.searchResultFetched()
                
            case .idle:
                break
            }
        })
    }
}

// MARK: - Observing Functions
extension AppStateObserver {
    func addObserver(observer: Observer) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }
    
    func removeObserver(observer: Observer) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
}
