class Rt < Formula
  desc "Developer CLI for branch management, service runner, daemon, and notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.6.0/rt-darwin-arm64-v2.6.0.tar.gz"
      sha256 "7e1e2021e779cd18d6a59a755ddbd18a5650d4baf6f22acbf91be11cee1f2c36"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.6.0/rt-darwin-x64-v2.6.0.tar.gz"
      sha256 "e70b51dfbd9e65fc728695b37be7bb0f077cf6791d81d81d03a698ec6b61a5ed"
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
