using Microsoft.Maui.Controls;
using Microsoft.Web.WebView2.Core;
using AVFoundation;

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
            if (myWebView.Handler?.PlatformView is Microsoft.UI.Xaml.Controls.WebView2 webView2)
            {
                webView2.CoreWebView2Initialized += (sender, args) =>
                {
                    webView2.CoreWebView2.WebMessageReceived += WebMessageReceived;
                };
            }
        };
    }

    private void WebMessageReceived(object sender, CoreWebView2WebMessageReceivedEventArgs e)
    {
        var message = e.TryGetWebMessageAsString();
        
        // 處理來自網頁的訊息
        if (message.Contains("play-sound"))
        {
            PlaySound();
        }
    }

    private void PlaySound()
    {
        try
        {
            // 播放音效
            var soundUrl = NSBundle.MainBundle.GetUrlForResource("notification", "wav");
            if (soundUrl != null)
            {
                var audioPlayer = new AVAudioPlayer(soundUrl, "wav", out var error);
                if (error == null)
                {
                    audioPlayer.Play();
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"播放音效失敗: {ex.Message}");
        }
    }
}
