import Queues
import Vapor

extension Application.Queues.Provider {
    public static var test: Self {
        .init {
            $0.queues.use(custom: TestQueuesDriver())
        }
    }
}

struct TestQueuesDriver: QueuesDriver {
    func makeQueue(with context: QueueContext) -> Queue {
        TestQueue(context: context)
    }
    
    func shutdown() {
        // nothing
    }
}

extension Application.Queues {
    public final class TestQueueStorage {
        public var jobs: [JobIdentifier: JobData] = [:]
        public var queue: [JobIdentifier] = []
        
        /// Returns the first job in the queue of the specific `J` type.
        public func first<J>(_ job: J.Type) -> J.Payload?
            where J: Job
        {
            let filteredJobIds = jobs.filter { $1.jobName == J.name }.map { $0.0 }
            guard
                let queueJob = queue.first(where: { filteredJobIds.contains($0) }),
                let jobData = jobs[queueJob]
                else {
                    return nil
            }
            
            return try? J.parsePayload(jobData.payload)
        }
        
        /// Checks whether a job of type `J` was dispatched to queue
        public func contains<J>(_ job: J.Type) -> Bool
            where J: Job
        {
            return first(job) != nil
        }
    }
    
    struct TestQueueKey: StorageKey, LockKey {
        typealias Value = TestQueueStorage
    }
    
    public var test: TestQueueStorage {
        if let existing = self.application.storage[TestQueueKey.self] {
            return existing
        } else {
            let new = TestQueueStorage()
            self.application.storage[TestQueueKey.self] = new
            return new
        }
    }
}

struct TestQueue: Queue {
    let context: QueueContext
    
    func get(_ id: JobIdentifier) -> EventLoopFuture<JobData> {
        return self.context.eventLoop.makeSucceededFuture(context.application.queues.test.jobs[id]!)
    }
    
    func set(_ id: JobIdentifier, to data: JobData) -> EventLoopFuture<Void> {
        context.application.queues.test.jobs[id] = data
        return self.context.eventLoop.makeSucceededFuture(())
    }
    
    func clear(_ id: JobIdentifier) -> EventLoopFuture<Void> {
        context.application.queues.test.jobs[id] = nil
        return self.context.eventLoop.makeSucceededFuture(())
    }
    
    func pop() -> EventLoopFuture<JobIdentifier?> {
        return self.context.eventLoop.makeSucceededFuture(context.application.queues.test.queue.popLast())
    }
    
    func push(_ id: JobIdentifier) -> EventLoopFuture<Void> {
        context.application.queues.test.queue.append(id)
        return self.context.eventLoop.makeSucceededFuture(())
    }
}
