using Microsoft.Maui.Controls;

namespace KDSMauiApp;

public partial class MainPage : ContentPage
{
    public MainPage()
    {
        InitializeComponent();
        SetupWebView();
    }

    private void SetupWebView()
    {
        // 設定 WebView 事件
        myWebView.HandlerChanged += (s, e) =>
        {
#if WINDOWS
            if (myWebView.Handler?.PlatformView is Microsoft.UI.Xaml.Controls.WebView2 webView2)
            {
                webView2.CoreWebView2Initialized += (sender, args) =>
                {
                    webView2.CoreWebView2.WebMessageReceived += WebMessageReceived;
                };
            }
#endif
        };
    }

#if WINDOWS
    private void WebMessageReceived(object sender, Microsoft.Web.WebView2.Core.CoreWebView2WebMessageReceivedEventArgs e)
    {
        var message = e.TryGetWebMessageAsString();
        
        // 處理來自網頁的訊息
        if (message.Contains("play-sound"))
        {
            PlaySound();
        }
    }
#endif

    private void PlaySound()
    {
        try
        {
#if IOS
            // iOS 音效播放
            var soundUrl = Foundation.NSBundle.MainBundle.GetUrlForResource("notification", "wav");
            if (soundUrl != null)
            {
                var audioPlayer = new AVFoundation.AVAudioPlayer(soundUrl, "wav", out var error);
                if (error == null)
                {
                    audioPlayer.Play();
                }
            }
#elif ANDROID
            // Android 音效播放
            // 這裡可以實作 Android 的音效播放
            System.Diagnostics.Debug.WriteLine("Android 音效播放功能待實作");
#elif WINDOWS
            // Windows 音效播放
            System.Diagnostics.Debug.WriteLine("Windows 音效播放功能待實作");
#endif
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"播放音效失敗: {ex.Message}");
        }
    }
}
