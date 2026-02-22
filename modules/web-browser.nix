{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Home Manager ではプロファイルごとに設定を記述します
    profiles.default = {
      # ここに about:config の設定を記述（Home Manager では settings を使用）
      settings = {
        # 前回のウィンドウとタブを開く
        "browser.startup.page" = 3;

        # 垂直タブとサイドバー
        "sidebar.verticalTabs" = true;
        "sidebar.main.expanded" = true;

        # 新しいタブ画面のカスタマイズ
        "browser.newtabpage.activity-stream.showWeather" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.sessionstore.resume_from_crash" = true;

        # 自動スペルチェックを無効化 (settings で行う場合)
        "layout.spellcheckDefault" = 0;
        
        # 言語設定 (settings で行う場合)
        "intl.accept_languages" = "ja, en-US";
      };
    };

    policies = {
      # DRM 制御コンテンツ
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = true;
      };
      RequestedLocales = [ "ja" "en-US" ];  # 言語設定
      DisableSetDesktopBackground = true;  # 右クリックメニューから「壁紙に設定」を無効化
      DisplayBookmarksToolbar = "never";  # ブックマークツールバー
      OfferToSaveLogins = false;  # パスワードの保存
      AutofillAddressEnabled = false;  # 住所の自動入力
      AutofillCreditCardEnabled = false;  # 支払い方法の自動入力
      ShowHomeButton = true;  # ホームボタン表示
      # 拡張機能
      # 調べ方: 拡張機能のページを開く
      # ├ Extension ID: ctrl+u -> 「"guid":」で検索 -> すぐ後ろの「"」で囲まれた文字列
      # └ install_url: https://addons.mozilla.org/firefox/downloads/latest/<アドオンのスラッグ>/latest.xpi
      #   └ アドオンのスラッグ: URL の「addon/」の後ろの名前
      ExtensionSettings = {
        # bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
        # adguard
        "adguardadblocker@adguard.com" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/adguard-adblocker/latest.xpi";
        };
        # raindrop.io
        "jid0-adyhmvsP91nUO8pRv0Mn2VKeB84@jetpack" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/raindropio/latest.xpi";
        };
        # Permanent Progress Bar for YouTube
        "{af838dcd-be8a-4237-8835-69fca92171d3}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/progress-bar-for-youtube/latest.xpi";
        };
        # Amazon のスポンサー商品・広告を非表示
        "amazon-unsponsor@github.com" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/amazonのスポンサー商品を非表示にする/latest.xpi";
        };
      };
    };
  };
}
