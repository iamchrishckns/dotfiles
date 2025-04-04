// General
user_pref("browser.startup.page", 3); // General > Startup > Open previous windows and tabs
user_pref("browser.tabs.warnOnClose", true); // General > Tabs > Confirm before closing multiple tabs

user_pref("layout.css.prefers-color-scheme.content-override", 0); // General > Website appearance > Dark

user_pref("layout.spellcheckDefault", 0); // General > Language > Check your spelling as you type 

user_pref("browser.download.useDownloadDir", false); // General > Files and Applications > Always ask you where to save files

// Home
user_pref("browser.startup.homepage", "https://duckduckgo.com"); // Home > New Windows and Tabs > Homepage and new windows
user_pref("browser.newtabpage.enabled", false); // Home > New Windows and Tabs > New tabs > Blank Page
user_pref("browser.newtabpage.activity-stream.showSearch", false); // Home > Firefox Home Content > Web Search
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false); // Home > Firefox Home Content > Shortcuts
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // Home > Firefox Home Content > Shortcuts > Sponsored shortcuts

user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false); // Home > Firefox Home Content > Recent activity
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false); // Home > Firefox Home Content > Recent activity > Visited Pages
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false); // Home > Firefox Home Content > Recent activity > Bookmarks
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false); // // Home > Firefox Home Content > Recent activity > Most Recent Download

// Search
user_pref("browser.urlbar.placeholderName", "DuckDuckGo"); // Search > Default Search Engine
user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned", "DuckDuckGo"); // Search > Default Search Engine

// Privacy & Security
user_pref("signon.rememberSignons", false); // Privacy & Security > Logins and Passwords > Ask to save logins and passwords for websites
user_pref("signon.autofillForms", false); // Privacy & Security > Logins and Passwords > Autofill logins and passwords
user_pref("signon.generation.enabled", false); // Privacy & Security > Logins and Passwords > Suggest and generate strong passwords
user_pref("signon.management.page.breach-alerts.enabled", false); // Privacy & Security > Logins and Passwords > Show alerts about passwords for breached websites

user_pref("extensions.formautofill.creditCards.enabled", false); // Privacy & Security > Forms and Autofill > Autofill credit cards

user_pref("datareporting.healthreport.uploadEnabled", false); // Privacy & Security > Firefox Data Collection and Use

user_pref("dom.security.https_only_mode", true); // Privacy & Security > Security > HTTPS-Only Mode
user_pref("dom.security.https_only_mode_ever_enabled", true); // Privacy & Security > Security > HTTPS-Only Mode
user_pref("dom.security.https_only_mode_ever_enabled_pbm", true); // Privacy & Security > Security > HTTPS-Only Mode

// Other 
user_pref("browser.bookmarks.addedImportButton", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("extensions.pocket.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.toolbars.bookmarks.visibility", "always");
user_pref("taskbar.grouping.useprofile", true); // Allow different use profiles to have their own taskbar group
user_pref("media.hardwaremediakeys.enabled", false); // Disbale media control keys
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.tabs.inTitlebar", 1);
user_pref("browser.tabs.warnOnClose", true);

// Profiles
user_pref("browser.profiles.enabled", true);
user_pref("browser.profiles.profile-name.updated", true);

// Tab Groups
user_pref("browser.tabs.groups.enabled", true);

// New Sidebar
user_pref("sidebar.revamp", true);
user_pref("sidebar.visibility", "hide-sidebar");
