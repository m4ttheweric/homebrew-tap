class Rt < Formula
  desc "Developer CLI for branch management, service runner, daemon, and notifications"
  homepage "https://github.com/m4ttstack/rt"
  version "2.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttstack/rt/releases/download/v2.7.0/rt-darwin-arm64-v2.7.0.tar.gz"
      sha256 "2854c8f4ed8bf654e5f5cbe7a3a59f8727155dff568539e1da45b17c07e0d2ab"
    end
    on_intel do
      url "https://github.com/m4ttstack/rt/releases/download/v2.7.0/rt-darwin-x64-v2.7.0.tar.gz"
      sha256 "dd3dbdf4b0cdcb72589b4461cb296c09354971a58638f69d5213cbe61aca1436"
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
