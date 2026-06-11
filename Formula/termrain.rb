class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.3.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.3.0/termrain-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "7e479261ac603b0ab29442c75ae290d6827ba26a802100dcc7912d0b236b42b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.3.0/termrain-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "b14e6f8f4a43a8eecbbbce1a04b3b57024bbb6aee25ded9b7706f4f95f3249bb"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.3.0/termrain-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "3492fb2818c62120b3bc247aa5cede497ae55283055cfccd1538de9646d33736"
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
