class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.0/rt-darwin-arm64-v1.3.0.tar.gz"
      sha256 "aca95753f32905784214e6d53bb3e2d6714d58a5a8fbee12171b41d99a65f232"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.0/rt-darwin-x64-v1.3.0.tar.gz"
      sha256 "58c98f6147da9cd131ac18adb4c3c7161e0dba10a46b84728b4bfff5295e1527"
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
