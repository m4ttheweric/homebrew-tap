class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.5.0/rt-darwin-arm64-v2.5.0.tar.gz"
      sha256 "db77ba1ffae838624b7bbf7df59d19486c12b326e0ade236e88a5ca48d0e3431"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.5.0/rt-darwin-x64-v2.5.0.tar.gz"
      sha256 "41e0ea67ea46b438b3775371bb21ca2bc1499988668b9d4906304942cbaa904a"
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
