class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.3.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.3.2/termrain-v0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "0a87f1b201af5996fd3d8211a9a8e2414022def6084ef2d30a295dc867d08a32"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.3.2/termrain-v0.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "15c892e11170e9a33110024ab6f0bf82cf89c15599aaafb17fb0829cde8c1b0a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.3.2/termrain-v0.3.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0068187ffd9ff4c82bac53f2641a92e96f89345e8a3c0b5d781f6290def6af7a"
  end

  def install
    bin.install "termrain"

    # bash / zsh / fish の補完スクリプトを自動生成して所定の場所に置く。
    # `termrain --completion <shell>` が stdout に補完を出すので、
    # Homebrew のヘルパーがそれを拾って install してくれる。
    generate_completions_from_executable(bin/"termrain", "--completion")

    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover = Dir["*"] - doc_files - ["termrain"]
    pkgshare.install(*leftover) unless leftover.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termrain --version")
  end
end
