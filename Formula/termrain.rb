class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.5.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.5.1/termrain-v0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "e518299f7302590255b1436d206c945be1b9a49697e393142c506ca45b66fdb2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.5.1/termrain-v0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "10637168798dc4df9eb62475da9e1135c5802c23e44eb87fbdde34c494bbb306"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.5.1/termrain-v0.5.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "48efb4e6567cd4005d9709905afbe74cf164ee2d36d66dddc106f1b285c9c1f0"
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
