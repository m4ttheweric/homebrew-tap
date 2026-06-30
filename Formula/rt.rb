class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.3/rt-darwin-arm64-v1.3.3.tar.gz"
      sha256 "449a23992a764ce61be26c0130199f1440c8c707473669937674a8a26fe2cf25"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.3/rt-darwin-x64-v1.3.3.tar.gz"
      sha256 "cf8031738551259684120fb0d957c217147fd4790a0aaab9aeefff2c258d1141"
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
