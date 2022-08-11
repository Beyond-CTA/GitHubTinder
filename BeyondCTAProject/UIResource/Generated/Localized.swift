// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum L10n {
  /// There is no README.
  public static let noReadmeText = L10n.tr("Localizable", "noReadmeText", fallback: "There is no README.")
  /// キーワードを変えてもう一度検索してください
  public static let noResultsAlertBody = L10n.tr("Localizable", "noResultsAlertBody", fallback: "キーワードを変えてもう一度検索してください")
  /// %@ の結果が見つかりませんでした
  public static func noResultsAlertTitle(_ p1: Any) -> String {
    return L10n.tr("Localizable", "noResultsAlertTitle", String(describing: p1), fallback: "%@ の結果が見つかりませんでした")
  }
  /// Enter search words..
  public static let searchPlacaholder = L10n.tr("Localizable", "searchPlacaholder", fallback: "Enter search words..")
  /// slider.vertical.3
  public static let verticalSlider = L10n.tr("Localizable", "verticalSlider", fallback: "slider.vertical.3")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
