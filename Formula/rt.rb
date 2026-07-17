class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "2.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.4.0/rt-darwin-arm64-v2.4.0.tar.gz"
      sha256 "6f4fc10a22b6eafb5f2f61a180dee4615eb8aa1d7584b61b2ef8536389e3d7c6"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v2.4.0/rt-darwin-x64-v2.4.0.tar.gz"
      sha256 "c502382d1f959e1f1a63de362f49515f685a196945fb4af95a5457b26e8cc86a"
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
