class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.3.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.4/rt-darwin-arm64-v1.3.4.tar.gz"
      sha256 "d7d9cd7bb3728557ab8c4a85c150f7a3ad0b1e77fb6489f29c28aaafc20f11c4"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.4/rt-darwin-x64-v1.3.4.tar.gz"
      sha256 "efe2bc816124991d0033ca4a378d7305af89f14f04bd62d401176487b7bbd409"
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
