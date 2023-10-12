//
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import Foundation
import SwiftData

@Model
final class Event {
    @Attribute(.unique) var id: UUID
    var title: String
    var detail: String
    var startDate: Date
    var endDate: Date
    var createdData: Date
    
    init(
        id: UUID,
        title: String,
        detail: String,
        startDate: Date,
        endDate: Date,
        createdData: Date
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.startDate = startDate
        self.endDate = endDate
        self.createdData = createdData
    }
}
