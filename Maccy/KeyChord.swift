import AppKit
import Sauce

enum KeyChord: CaseIterable {
  case clearHistory
  case clearHistoryAll
  case clearSearch
  case deleteCurrentItem
  case deleteOneCharFromSearch
  case deleteLastWordFromSearch
  case hide
  case ignored
  case moveToNext
  case moveToPrevious
  case openPreferences
  case paste
  case pinOrUnpin
  case selectCurrentItem
  case unknown

  // swiftlint:disable cyclomatic_complexity
  init(_ key: Key, _ modifierFlags: NSEvent.ModifierFlags) {
    switch (key, modifierFlags) {
    case (.delete, MenuFooter.clear.keyEquivalentModifierMask):
      self = .clearHistory
    case (.delete, MenuFooter.clearAll.keyEquivalentModifierMask):
      self = .clearHistoryAll
    case (.delete, [.command]), (.u, [.control]):
      self = .clearSearch
    case (.delete, [.option]):
      self = .deleteCurrentItem
    case (.delete, []), (.h, [.control]):
      self = .deleteOneCharFromSearch
    case (.w, [.control]):
      self = .deleteLastWordFromSearch
    case (.j, [.control]):
      self = .moveToNext
    case (.k, [.control]):
      self = .moveToPrevious
    case (.p, [.option]):
      self = .pinOrUnpin
    case (GlobalHotKey.key, GlobalHotKey.modifierFlags):
      self = .hide
    case (.comma, MenuFooter.preferences.keyEquivalentModifierMask):
      self = .openPreferences
    case (.v, [.command]):
      self = .paste
    case (.return, _), (.keypadEnter, _):
      self = .selectCurrentItem
    case (_, _) where Self.keysToSkip.contains(key) || !modifierFlags.isDisjoint(with: Self.modifiersToSkip):
      self = .ignored
    default:
      self = .unknown
    }
  }
  // swiftlint:enable cyclomatic_complexity

  private static let keysToSkip = [
    Key.home,
    Key.pageUp,
    Key.pageDown,
    Key.end,
    Key.downArrow,
    Key.leftArrow,
    Key.rightArrow,
    Key.upArrow,
    Key.escape,
    Key.tab,
    Key.f1,
    Key.f2,
    Key.f3,
    Key.f4,
    Key.f5,
    Key.f6,
    Key.f7,
    Key.f8,
    Key.f9,
    Key.f10,
    Key.f11,
    Key.f12,
    Key.f13,
    Key.f14,
    Key.f15,
    Key.f16,
    Key.f17,
    Key.f18,
    Key.f19
  ]
  private static let modifiersToSkip = NSEvent.ModifierFlags([
    .command,
    .control,
    .option
  ])
}
