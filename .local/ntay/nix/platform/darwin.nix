{ self, pkgs, user, homePath, ... }:
let
  homeDir = homePath;
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # TODO: Modularise to be 'base' (headless essentials), 'gui(?)', 'macos'
  environment.systemPackages = with pkgs; [
    gnused
    gnugrep
    gawk

    nmap
    socat

    #git  (retain system version for CA cert + keychain etc integration on darwin)
  ];

  fonts.packages = with pkgs; [
    fantasque-sans-mono
  ];

  homebrew = {
    enable = true;

    onActivation = {
      #autoUpdate = false;
      #upgrade    = false;
      cleanup    = "none";  # TODO: probably switch to 'zap' eventually
    };

    # Should keep as CASKS ONLY
    casks = [
      "firefox"
      "iterm2"

      "easy-move+resize"
      "sensiblesidebuttons"
      "unnaturalscrollwheels"
      "thaw"

      "maccy"
      "alt-tab"

      "obsidian"

      "wireshark-app"
    ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Auto optimise the store - default is daily in early morning
  # (since it uses launchd-style config, it will "catchup" on next wakeup if sleeping)
  # Manual: $ nix-store --optimise
  nix.optimise.automatic = true;
  # Auto cleanup the old generations - same default early morning schedule
  # Manual: $ nix-collect-garbage <options> (-d for all generations)
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 21d";
  };

  # Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Must be set for system.defaults to find the Primary user. 
  system.primaryUser = user;

  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;  # Disable accents hold menu
      InitialKeyRepeat = 12;

      # 24-hour clock status bar
      AppleICUForce24HourTime = true;

      # Tab to cycle between all controls, not just text fields
      AppleKeyboardUIMode = 2;

      # Disable all auto-completes. I'm using a damn computer.
      NSAutomaticCapitalizationEnabled     = false;
      NSAutomaticDashSubstitutionEnabled   = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled  = false;

      # Ctrl+Cmd drag window
      NSWindowShouldDragOnGesture = true;

      # Tap to click trackpad
      "com.apple.mouse.tapBehavior" = 1;
    };

    # Show volume in menu bar
    controlcenter.Sound = true;

    dock = {
      # No rearranging spaces by recent use
      mru-spaces = false;

      magnification = true;
      largesize     = 65;
      tilesize      = 59;

      # Three finger swipe down reveal
      showAppExposeGestureEnabled = true;

      # Hot corners
      wvous-bl-corner = 13;  # Bottom-left = Lock Screen

      # Dock entries - TODO: Decide base home setup.
      # persistent-apps = [
      #   "/Applications/Firefox.app"
      #   "/Applications/Mattermost.app"
      #   "/Applications/Microsoft Outlook.app"
      #   "/System/Applications/Notes.app"
      #   "/System/Applications/TextEdit.app"
      #   "/Applications/zoom.us.app"
      #   "/Applications/Google Chrome.app"
      #   "/System/Applications/Utilities/Activity Monitor.app"
      #   "/System/Applications/Stickies.app"
      #   "/Applications/Obsidian.app"
      #   "/Applications/Visual Studio Code.app"
      #   "/Applications/TurboVNC/TurboVNC Viewer.app"
      #   "/Applications/Windows App.app"
      #   "/System/Applications/Calendar.app"
      #   "/Applications/Microsoft PowerPoint.app"
      #   "/System/Applications/Preview.app"
      #   "/Applications/NetNewsWire.app"
      #   "/Applications/iTerm.app"
      #   "/System/Applications/System Settings.app"
      # ];
      persistent-others = [
        "${homeDir}/Documents/Screenshots"
        "${homeDir}/Downloads"
      ];
    };

    finder = {
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv";  # List view default
    };

    WindowManager = {
      # Disable "click to reveal" on desktop annoyance
      EnableStandardClickToShowDesktop = false;

      StandardHideWidgets = true;
    };

    screencapture = {
      location = "${homeDir}/Documents/Screenshots";
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        AppleAccentColor = 6;  # Pink accent
        AppleHighlightColor = "1.000000 0.749020 0.823529 Pink";  # Pink selection highlight
      };

      # Don't show Spotlight magnifying glass button in menu bar
      "${homeDir}/Library/Preferences/ByHost/com.apple.Spotlight".MenuItemHidden = true;

      # Show Input Method in menu bar
      "com.apple.TextInputMenu".visible = true;
      # TODO: Review if required all this cruft (extracted from old mac 'defaults')
      "com.apple.HIToolbox".AppleEnabledInputSources = [
        { InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 15; "KeyboardLayout Name" = "Australian"; }
        { "Bundle ID" = "com.apple.CharacterPaletteIM"; InputSourceKind = "Non Keyboard Input Method"; }
        { "Bundle ID" = "com.apple.PressAndHold"; InputSourceKind = "Non Keyboard Input Method"; }
        { "Bundle ID" = "com.apple.inputmethod.SCIM"; InputSourceKind = "Keyboard Input Method"; }
        { "Bundle ID" = "com.apple.inputmethod.SCIM"; "Input Mode" = "com.apple.inputmethod.SCIM.ITABC"; InputSourceKind = "Input Mode"; }   # Pinyin - Simplified
        { "Bundle ID" = "com.apple.inputmethod.Korean"; InputSourceKind = "Keyboard Input Method"; }
        { "Bundle ID" = "com.apple.inputmethod.Korean"; "Input Mode" = "com.apple.inputmethod.Korean.2SetKorean"; InputSourceKind = "Input Mode"; }
        { "Bundle ID" = "com.apple.inputmethod.Kotoeri.RomajiTyping"; "Input Mode" = "com.apple.inputmethod.Japanese"; InputSourceKind = "Input Mode"; }
        { "Bundle ID" = "com.apple.inputmethod.Kotoeri.RomajiTyping"; InputSourceKind = "Keyboard Input Method"; }
        { "Bundle ID" = "com.apple.50onPaletteIM"; InputSourceKind = "Non Keyboard Input Method"; }
      ];

      # NOTE: This overrides ALL key shortcuts, so manage it all in here
      # ctrl=262144, opt=524288 (ctrl+opt=786432), shift=131072, cmd=1048576
      # space = 32/49
      # parameters = [ ASCII, keyCode, modifierMask ]
      "com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
        # Next input source = 61 -> control+option+space enabled
        "61" = { enabled = true; value = { type = "standard"; parameters = [ 32 49 786432 ]; }; };
      };

      # Don't reopen stuff when I shutdown/logoff
      "com.apple.loginwindow".TALLogoutSavesState = false;
    };

    universalaccess = {
      mouseDriverCursorSize = 1.87;
    };

    trackpad = {
      # Tap to click
      Clicking = true;

      # TODO: Try three finger drag gesture?
    };
  };

  system.keyboard = {
    enableKeyMapping = true;      # required for any remap below to affect
    remapCapsLockToEscape = true;
  };
}
