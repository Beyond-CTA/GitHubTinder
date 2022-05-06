//
//  PKHUD+.swift
//  BeyondCTAProject
//
//  Created by Taisei Sakamoto on 2022/04/29.
//

import Foundation
import PKHUD

extension HUDContentType: Equatable {
    public static func == (lhs: HUDContentType, rhs: HUDContentType) -> Bool {
        switch lhs {
        case .success:
            if case .success = rhs { return true } else { return false }

        case .error:
            if case .error = rhs { return true } else { return false }

        case .progress:
            if case .progress = rhs { return true } else { return false }

        case .image:
            if case .image = rhs { return true } else { return false }

        case .rotatingImage:
            if case .rotatingImage = rhs { return true } else { return false }

        case .labeledSuccess:
            if case .labeledSuccess = rhs { return true } else { return false }

        case .labeledError:
            if case .labeledError = rhs { return true } else { return false }

        case .labeledProgress:
            if case .labeledProgress = rhs { return true } else { return false }

        case .labeledImage:
            if case .labeledImage = rhs { return true } else { return false }

        case .labeledRotatingImage:
            if case .labeledRotatingImage = rhs { return true } else { return false }

        case .label:
            if case .label = rhs { return true } else { return false }

        case .systemActivity:
            if case .systemActivity = rhs { return true } else { return false }

        case .customView:
            if case .customView = rhs { return true } else { return false }
        }
    }
}
