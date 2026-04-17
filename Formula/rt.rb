class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.18"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.18/rt-darwin-arm64-v1.0.18.tar.gz"
      sha256 "e8b2ed63fca87f999e254c9e8ea27a9def47b1249492b7d79815730c48fc3d83"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.18/rt-darwin-x64-v1.0.18.tar.gz"
      sha256 "b6671ee2415c2ab34fa7d44256651a43256cbde03ada8c147a7c8a776e360eb1"
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
