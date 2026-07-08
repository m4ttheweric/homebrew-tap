class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.2.0/rt-darwin-arm64-v2.2.0.tar.gz"
      sha256 "4d94d0bb99ecd16f6d53e35d2f147945e0097df3e63c3b2565c6247b95d45eb3"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.2.0/rt-darwin-x64-v2.2.0.tar.gz"
      sha256 "d40b22e585d8a0dede8d28882bdec244361e0380cee17caeaac1fe3b4304174b"
    end
  end

  depends_on :macos
  depends_on "fzf"
  depends_on "tmux"

  def install
    bin.install "rt"
    prefix.install "rt-tray.app"
    prefix.install "rt-context.vsix"
  end

  # No post_install hook: Homebrew runs hooks in a sandbox that can't
  # write to ~/Applications, ~/.rt, or shell rc files. Setup is handled
  # by the binary on first invocation (or via `rt verify`).

  def caveats
    <<~EOS
      Complete setup + verify the install:
        rt verify

      Then configure your API tokens:
        rt settings linear token
        rt settings gitlab token
    EOS
  end
end
