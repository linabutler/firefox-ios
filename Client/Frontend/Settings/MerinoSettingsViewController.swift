// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import UIKit
import Shared

class MerinoSettingsViewController: SettingsTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Merino"
    }

    override func generateSettings() -> [SettingSection] {
        let prefs = profile.prefs

        let attributes = [NSAttributedString.Key.foregroundColor: themeManager.currentTheme.colors.textPrimary]
        let enabled = BoolSetting(
            prefs: prefs,
            prefKey: PrefsKeys.FeatureFlags.Merino,
            defaultValue: false,
            attributedTitleText: NSAttributedString(
                string: "Enable Merino",
                attributes: attributes)
        ) { isOn in
            self.settings = self.generateSettings()
            self.tableView.reloadData()
        }

        let customServerURL = WebPageSetting(
            prefs: prefs,
            prefKey: PrefsKeys.CustomMerinoServerURL,
            placeholder: "Custom Merino server URL",
            accessibilityIdentifier: "CustomMerinoServer"
        )
        customServerURL.textField.clearButtonMode = .always

        var sections: [SettingSection] = [SettingSection(title: nil, children: [enabled])]
        if prefs.boolForKey(PrefsKeys.FeatureFlags.Merino) ?? false {
            sections.append(SettingSection(title: nil, children: [customServerURL]))
        }
        return sections
    }
}
