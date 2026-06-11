class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.2.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.2.2/termrain-v0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "b791730d7d5f2bb7a31ffca6bf4987f1a44efd3f2f3e4f1330a399aa50c0f92e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.2.2/termrain-v0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "53706cb0ee1493be4a0500c236ea68376d40edba805b84b793d69fd69cc10cc5"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.2.2/termrain-v0.2.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "5abfa213de537f717cb0c4ce0d10780fc97702c02b7852359ad5bc9350af33dd"
  end

  def install
    bin.install "termrain"

    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover = Dir["*"] - doc_files - ["termrain"]
    pkgshare.install(*leftover) unless leftover.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termrain --version")
  end
end
