class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.4/rt-darwin-arm64-v1.0.4.tar.gz"
      sha256 "62c7244513f91476a0d4bc3ca10466b991cba7ee0e01e5191eb580c96f81591a"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.4/rt-darwin-x64-v1.0.4.tar.gz"
      sha256 "693cfd05b4e29d7f7995d015e596a0052758f28b3c958ff8fa039857e08efbaa"
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
      Complete setup (tray app, daemon, shell integration):
        rt --post-install

      Then configure your API tokens:
        rt settings linear token
        rt settings gitlab token

      Verify the installation:
        rt verify
    EOS
  end
end
