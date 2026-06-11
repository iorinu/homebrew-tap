class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.3.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.3.0/termrain-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "3ea6f84233af43cf5cd52a2a42687b5a9b52cde2cb2ebfefb4c24714c3bf8af1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.3.0/termrain-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "6461bc5a65e692447eebb36d7b48fd11a10a147d8c837fd440b1bc178fedac50"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.3.0/termrain-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "8db22a70ad5f51a1fbb7245dedda8e6d4bc590efc9475e7fab1f1d0d5893aebc"
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
