class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.1.0/rt-darwin-arm64-v2.1.0.tar.gz"
      sha256 "381d4cf01e91b90c0d1354d13214a8f7a1349ecde13835f87266b19e8312c681"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.1.0/rt-darwin-x64-v2.1.0.tar.gz"
      sha256 "c8fb7fbececa074e5acfc1ece468d3c50b07f2496f6ad0c02200af51c2c628da"
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
