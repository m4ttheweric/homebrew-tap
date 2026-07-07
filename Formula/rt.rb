class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.0.2/rt-darwin-arm64-v2.0.2.tar.gz"
      sha256 "9ff71c13a32a2a2fc73c84f17eabd39469606dca457e624891dde37ef04e870e"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.0.2/rt-darwin-x64-v2.0.2.tar.gz"
      sha256 "10aeed0d2ed8d5f4a561d4cb71b9dd29ab1f1697d5124b5637cb71c093ab0f45"
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
