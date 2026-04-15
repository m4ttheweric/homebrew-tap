class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-arm64-v1.0.0.tar.gz"
      sha256 "76623993aa391f44c1ad3c9d24bcc17641f91a09cf54f57c8681586c809e334a"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-x64-v1.0.0.tar.gz"
      sha256 "95eab1a14e8849146f746d58bd9bd9dfa6d3e5a428869a09387053500ca7796c"
    end
  end

  depends_on :macos
  depends_on "fzf"
  depends_on "terminal-notifier" => :recommended
  depends_on "zellij" => :recommended

  def install
    bin.install "rt"
    prefix.install "rt-tray.app"
    prefix.install "rt-context.vsix"
  end

  def post_install
    # All setup logic lives in the binary — versioned alongside the code.
    system bin / "rt", "--post-install"
  end


  def caveats
    <<~EOS
      Configure your API tokens:
        rt settings linear token
        rt settings gitlab token

      Restart your terminal, then verify:
        rt doctor
    EOS
  end
end
