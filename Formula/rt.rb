class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-arm64-v1.0.0.tar.gz"
      sha256 "88b5a7430eeeb74113bb79f166a330faf23fcf1a865e9f2a0c0fd8963e7e7df5"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-x64-v1.0.0.tar.gz"
      sha256 "2e0fcdc980252bd632ce48fa5181905a9e0f045b123a1a6aad14f5994a53e258"
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
