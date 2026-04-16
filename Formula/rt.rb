class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.13/rt-darwin-arm64-v1.0.13.tar.gz"
      sha256 "c2133bb20abba8c81b0968cf9680204b81fe9473b2e16b607ebad2b1f3962552"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.13/rt-darwin-x64-v1.0.13.tar.gz"
      sha256 "37b7ad7a2ca07477159f027f33f2f8b3cc5e42601e204de3bfbab6fb7a9b881e"
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
