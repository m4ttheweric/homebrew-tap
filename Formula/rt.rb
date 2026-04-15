class Rt < Formula
  desc "Developer CLI — branch management, service runner, daemon, notifications"
  homepage "https://github.com/m4ttheweric/repo-tools"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-arm64-v1.0.0.tar.gz"
      sha256 "cc2e2622d813a72283eda4f18d25b3e319df87362553acc6dac520664468b77f"
    end
    on_intel do
      url "https://github.com/m4ttheweric/repo-tools/releases/download/v1.0.0/rt-darwin-x64-v1.0.0.tar.gz"
      sha256 "abeb8442172a7f208688127e2522607d0476fd5a2019a4065add406f4c235de3"
    end
  end

  depends_on :macos
  depends_on "fzf"
  depends_on "terminal-notifier" => :recommended
  depends_on "zellij" => :recommended

  def install
    bin.install "rt"
    prefix.install "rt-tray.app"
    prefix.install "rt-context.vsix"
  end

  def post_install
    # Tray app → ~/Applications
    apps_dir = Pathname.new(Dir.home) / "Applications"
    apps_dir.mkpath
    FileUtils.rm_rf(apps_dir / "rt-tray.app")
    FileUtils.cp_r(prefix / "rt-tray.app", apps_dir / "rt-tray.app")
    system "xattr", "-cr", (apps_dir / "rt-tray.app").to_s

    # Extension → local editors
    vsix = (prefix / "rt-context.vsix").to_s
    system "cursor", "--install-extension", vsix, "--force" if which("cursor")
    system "code", "--install-extension", vsix, "--force" if which("code")

    # Daemon
    system bin / "rt", "daemon", "install", "--manual"

    # Shell integration (idempotent)
    zshrc = Pathname.new(Dir.home) / ".zshrc"
    marker = "# rt — repo tools"
    unless zshrc.exist? && zshrc.read.include?(marker)
      zshrc.open("a") do |f|
        f.puts "", marker
        f.puts 'rt-cd() { local dir=$(rt cd 2>/dev/null); [ -n "$dir" ] && cd "$dir"; }'
        f.puts "alias rtcd='rt-cd'"
      end
    end
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
