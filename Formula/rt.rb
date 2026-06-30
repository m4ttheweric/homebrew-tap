class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.2/rt-darwin-arm64-v1.3.2.tar.gz"
      sha256 "8449b47a0dedff8603f7dd690964dff1444d17681a121082e56040e7f905cb83"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.3.2/rt-darwin-x64-v1.3.2.tar.gz"
      sha256 "082a67096d9cc030cbf32a78a517694f6b8297a91d935a803f53bf52bcc311fa"
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
