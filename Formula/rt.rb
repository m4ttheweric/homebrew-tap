class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.3/rt-darwin-arm64-v1.3.3.tar.gz"
      sha256 "fc5900b55121cd34010f1dca4576bcb0972fc92d03930d6fca25aef851c6580d"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.3/rt-darwin-x64-v1.3.3.tar.gz"
      sha256 "6038f5131f725e058ce4d48d58f4b82683b5da43622588b739195a71463e0ca4"
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
