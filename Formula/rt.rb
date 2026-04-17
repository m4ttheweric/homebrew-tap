class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.17"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.17/rt-darwin-arm64-v1.0.17.tar.gz"
      sha256 "c3e94dc726771051ac066f8882b984905872c8ab3822b0aa3df104aacc75f770"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.17/rt-darwin-x64-v1.0.17.tar.gz"
      sha256 "c7bb33a4056300f7146ced39d839c5cd771ed3c53f518ac17194585191740b54"
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
