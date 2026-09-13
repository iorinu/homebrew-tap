class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.5.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.5.0/termrain-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "c9cdf666d1b9cd52392a8f8c09bc9adcaaf9d359d8624ca3be0e090d6e7d0a7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.5.0/termrain-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "0a3d70fd25e45df0951cd8620865a947449deb05589e05d7881bfbea63e95292"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.5.0/termrain-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "7de92fcf8f2c4c54c409dd528074c811f9b676bcba692d00ed558aca2ff80d7b"
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
