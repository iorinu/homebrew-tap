class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.1.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.1.0/termrain-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "63fa03bc2bca273988dc174c169c8d925b6b0ef88cfe5b6de8f1e28006ff61a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.1.0/termrain-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "7e329bc6396150ebfeac89c72a13c058dfad1923d908ab6ad436bf27ff86a024"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.1.0/termrain-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "47fcd80b0ff8293e89da55c3c131158742dd6ef04ea3c8e75b6987684ef05451"
  end

  def install
    bin.install "termrain"

    # README / LICENSE はアーカイブに同梱しているので Homebrew に任せる
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover = Dir["*"] - doc_files - ["termrain"]
    pkgshare.install(*leftover) unless leftover.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termrain --version")
  end
end
