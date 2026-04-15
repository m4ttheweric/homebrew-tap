class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-arm64-v1.0.0.tar.gz"
      sha256 "d773d84fd20858c7b177e063e27679da16443bafe85f649fe54c817ae6af6fda"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-x64-v1.0.0.tar.gz"
      sha256 "c8174b6309664ed2e3cc4185cc757596904221d00cde4982c565c3f432b3e70c"
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

  def post_install
    # All setup logic lives in the binary — versioned alongside the code.
    system bin / "rt", "--post-install"
  end


  def caveats
    <<~EOS
      Configure your API tokens:
        rt settings linear token
        rt settings gitlab token

      Restart your terminal, then verify:
        rt doctor
    EOS
  end
end
